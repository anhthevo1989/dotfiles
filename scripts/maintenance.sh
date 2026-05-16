#!/bin/sh
set -eu

if [ "${DEBUG:-0}" = "1" ]; then
    set -x
fi

# ==========================================================
# FILE: scripts/maintenance.sh
# ==========================================================
#
# PURPOSE
# -------
# Run routine Arch Linux system maintenance.
#
# WHY IT EXISTS
# -------------
# Arch is a rolling-release system. Updates are normal, but they
# should be handled carefully and consistently.
#
# HOW IT WORKS
# ------------
# This script:
#
# - refreshes mirrors
# - opens Arch news before updating
# - updates official repository packages
# - updates AUR packages
# - removes orphaned dependencies
# - cleans package cache
# - checks basic system health
# - checks systemd errors from this boot
#
# BEGINNER NOTES
# --------------
# Always read Arch news before updating.
#
# If Arch news mentions manual intervention, stop and follow those
# instructions before continuing.
#

# ----------------------------------------------------------
# CONFIGURATION
# ----------------------------------------------------------

total_steps=9
current_step=0

log_dir="$HOME/.local/share/dotfiles"
log_file="$log_dir/maintenance.log"

reflector_config="/etc/xdg/reflector/reflector.conf"

# ----------------------------------------------------------
# COLORS
# ----------------------------------------------------------

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
lib_dir="$script_dir/lib"
colors_file="$lib_dir/pulse-colors.sh"

if [ ! -f "$colors_file" ]; then
    printf "Pulse color library not found: %s\n" "$colors_file"
    exit 1
fi

# shellcheck source=/dev/null
. "$colors_file"

# ----------------------------------------------------------
# UI HELPERS
# ----------------------------------------------------------

print_title() {
    printf '\n%s%s╭────────────────────────────────────────╮%s\n' "$bold" "$cyan" "$reset"
    printf '%s%s│ Arch Maintenance                       │%s\n' "$bold" "$cyan" "$reset"
    printf '%s%s│ System update + cleanup helper         │%s\n' "$bold" "$cyan" "$reset"
    printf '%s%s╰────────────────────────────────────────╯%s\n' "$bold" "$cyan" "$reset"
    printf '%sMirrors, news, packages, AUR, cache, health, logs.%s\n' "$dim" "$reset"
}

print_step() {
    current_step=$((current_step + 1))
    printf '\n%s[%s/%s]%s %s%s%s\n' "$cyan" "$current_step" "$total_steps" "$reset" "$bold" "$1" "$reset"
}

print_info() {
    printf '  %s→%s %s\n' "$blue" "$reset" "$1"
}

print_success() {
    printf '  %s✓%s %s\n' "$green" "$reset" "$1"
}

print_warning() {
    printf '  %s!%s %s\n' "$yellow" "$reset" "$1"
}

print_error() {
    printf '  %s✗%s %s\n' "$red" "$reset" "$1"
}

print_note() {
    printf '  %s-%s %s\n' "$magenta" "$reset" "$1"
}

die() {
    print_error "$1"
    printf '\n%sWhat happened:%s\n' "$bold" "$reset"
    printf '%s\n' "$2"
    printf '\n%sHow to fix:%s\n' "$bold" "$reset"
    printf '%s\n' "$3"
    printf '\nLog file:\n%s\n\n' "$log_file"
    exit 1
}

confirm() {
    prompt="$1"

    printf '  %s?%s %s [y/N]: ' "$yellow" "$reset" "$prompt"
    read answer || answer=""

    case "$answer" in
    y | Y | yes | YES)
        return 0
        ;;
    *)
        return 1
        ;;
    esac
}

pause() {
    printf '  %s?%s Press Enter to continue, or Ctrl+C to stop... ' "$yellow" "$reset"
    read _ || true
}

# ----------------------------------------------------------
# LOGGING HELPERS
# ----------------------------------------------------------

prepare_log() {
    mkdir -p "$log_dir"
    : >"$log_file"
}

run_cmd() {
    description="$1"
    shift

    print_info "$description"

    if "$@" >>"$log_file" 2>&1; then
        return 0
    fi

    return 1
}

run_root_cmd() {
    description="$1"
    shift

    if [ "$(id -u)" -eq 0 ]; then
        run_cmd "$description" "$@"
    else
        run_cmd "$description" sudo "$@"
    fi
}

# ----------------------------------------------------------
# REQUIREMENT HELPERS
# ----------------------------------------------------------

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

require_command() {
    command_name="$1"

    if ! command_exists "$command_name"; then
        die "$command_name was not found" \
            "The script needs $command_name, but it is not installed or not available in PATH." \
            "Install $command_name, then rerun this script."
    fi

    print_success "$command_name found"
}

require_arch() {
    if [ ! -f /etc/arch-release ]; then
        die "This does not look like Arch Linux" \
            "/etc/arch-release was not found." \
            "Run this only on an Arch-based system."
    fi

    print_success "Arch Linux detected"
}

# ----------------------------------------------------------
# MAINTENANCE STEPS
# ----------------------------------------------------------

check_system() {
    prepare_log

    print_note "Log file: $log_file"

    require_arch
    require_command "sudo"
    require_command "pacman"
    require_command "journalctl"

    print_success "System checks passed"
}

refresh_mirrors() {
    print_step "Refreshing mirrors"

    if ! command_exists reflector; then
        print_warning "reflector is not installed"
        print_note "Skipping mirror refresh"
        print_note "Install reflector if you want automatic mirror refreshes"
        return
    fi

    if [ -f "$reflector_config" ]; then
        if run_root_cmd "Refreshing mirrors with reflector config" reflector --config "$reflector_config"; then
            print_success "Mirrors refreshed"
        else
            die "Mirror refresh failed" \
                "reflector failed while using $reflector_config." \
                "Check your reflector config, internet connection, and country list."
        fi
    else
        if run_root_cmd "Refreshing mirrors with safe defaults" reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist; then
            print_success "Mirrors refreshed"
        else
            die "Mirror refresh failed" \
                "reflector could not generate a fresh mirror list." \
                "Check your internet connection, then try running reflector manually."
        fi
    fi
}

check_arch_news() {
    print_step "Checking Arch news"

    print_warning "Read Arch news before updating."
    print_note "If manual intervention is listed, stop and handle it first."
    print_note "URL: https://archlinux.org/news/"

    if command_exists xdg-open; then
        run_cmd "Opening Arch news in browser" xdg-open "https://archlinux.org/news/" || true
    fi

    pause
}

update_official_packages() {
    print_step "Updating official repo packages"

    print_note "This runs: sudo pacman -Syu"

    if run_root_cmd "Updating official packages" pacman -Syu; then
        print_success "Official packages updated"
    else
        die "Official package update failed" \
            "pacman failed while updating official repository packages." \
            "Read the log, check Arch news, then retry with: sudo pacman -Syu"
    fi
}

update_aur_packages() {
    print_step "Updating AUR packages"

    if command_exists yay; then
        print_note "AUR helper detected: yay"

        if run_cmd "Updating AUR packages with yay" yay -Sua; then
            print_success "AUR packages updated"
        else
            die "AUR update failed" \
                "yay failed while updating AUR packages." \
                "Check the log for the failing package, then rebuild or remove it manually."
        fi

        return
    fi

    if command_exists paru; then
        print_note "AUR helper detected: paru"

        if run_cmd "Updating AUR packages with paru" paru -Sua; then
            print_success "AUR packages updated"
        else
            die "AUR update failed" \
                "paru failed while updating AUR packages." \
                "Check the log for the failing package, then rebuild or remove it manually."
        fi

        return
    fi

    print_warning "No AUR helper found"
    print_note "Skipping AUR updates"
    print_note "Install yay or paru if you want this script to update AUR packages"
}

clean_orphans() {
    print_step "Cleaning unnecessary dependencies"

    orphans="$(pacman -Qtdq 2>/dev/null || true)"

    if [ -z "$orphans" ]; then
        print_success "No orphaned packages found"
        return
    fi

    print_warning "Orphaned packages found:"
    printf '%s\n' "$orphans" | while IFS= read -r package; do
        printf '  %s-%s %s\n' "$yellow" "$reset" "$package"
    done

    if confirm "Remove orphaned packages?"; then
        if run_root_cmd "Removing orphaned packages" pacman -Rns --noconfirm $orphans; then
            print_success "Orphaned packages removed"
        else
            die "Orphan cleanup failed" \
                "pacman failed while removing orphaned packages." \
                "Review the log, then try manually with: sudo pacman -Rns \$(pacman -Qtdq)"
        fi
    else
        print_warning "Skipped orphan cleanup"
    fi
}

clean_package_cache() {
    print_step "Cleaning package cache"

    if command_exists paccache; then
        print_note "Keeping the 3 most recent cached versions of installed packages"

        if run_root_cmd "Cleaning pacman cache" paccache -r; then
            print_success "Pacman cache cleaned"
        else
            die "Pacman cache cleanup failed" \
                "paccache failed while cleaning cached package versions." \
                "Install or reinstall pacman-contrib, then retry."
        fi

        print_note "Removing cached packages that are no longer installed"

        if run_root_cmd "Cleaning uninstalled package cache" paccache -ruk0; then
            print_success "Uninstalled package cache cleaned"
        else
            die "Uninstalled cache cleanup failed" \
                "paccache failed while removing cache for uninstalled packages." \
                "Check the log, then retry manually with: sudo paccache -ruk0"
        fi
    else
        print_warning "paccache is not installed"
        print_note "Skipping pacman cache cleanup"
        print_note "Install pacman-contrib to enable safe package cache cleanup"
    fi

    if command_exists yay; then
        if confirm "Clean yay cache?"; then
            if run_cmd "Cleaning yay cache" yay -Sc --noconfirm; then
                print_success "yay cache cleaned"
            else
                print_warning "yay cache cleanup failed"
                print_note "Continuing because system packages were already handled"
            fi
        else
            print_warning "Skipped yay cache cleanup"
        fi
    elif command_exists paru; then
        if confirm "Clean paru cache?"; then
            if run_cmd "Cleaning paru cache" paru -Sc --noconfirm; then
                print_success "paru cache cleaned"
            else
                print_warning "paru cache cleanup failed"
                print_note "Continuing because system packages were already handled"
            fi
        else
            print_warning "Skipped paru cache cleanup"
        fi
    fi
}

check_system_health() {
    print_step "Checking system health"

    print_note "Checking failed systemd units"

    if run_cmd "Writing failed systemd units to log" systemctl --failed; then
        failed_units="$(systemctl --failed --no-legend 2>/dev/null | wc -l | tr -d ' ')"

        if [ "$failed_units" = "0" ]; then
            print_success "No failed systemd units found"
        else
            print_warning "$failed_units failed systemd unit(s) found"
            print_note "Run manually: systemctl --failed"
        fi
    else
        print_warning "Could not check failed systemd units"
    fi

    print_note "Checking disk usage"
    df -h / | tee -a "$log_file"

    print_note "Checking memory usage"
    free -h | tee -a "$log_file"

    if command_exists sensors; then
        print_note "Checking temperatures with sensors"
        sensors | tee -a "$log_file"
    else
        print_warning "lm_sensors is not installed"
        print_note "Install lm_sensors if you want temperature checks"
    fi
}

check_systemd_logs() {
    print_step "Checking systemd logs"

    print_note "Showing errors from this boot"
    print_note "This runs: journalctl -p 3 -xb"

    if confirm "Open systemd error log now?"; then
        journalctl -p 3 -xb
    else
        print_warning "Skipped interactive log view"
    fi

    if run_cmd "Writing systemd errors to log file" journalctl -p 3 -xb; then
        print_success "Systemd errors written to log"
    else
        print_warning "Could not write systemd errors to log"
    fi
}

finish_maintenance() {
    print_step "Finished"

    printf '\n%s%sMaintenance complete.%s\n' "$bold" "$green" "$reset"

    printf '\n%sSummary:%s\n' "$bold" "$reset"
    printf '  %s✓%s Mirrors handled\n' "$green" "$reset"
    printf '  %s✓%s Arch news checked\n' "$green" "$reset"
    printf '  %s✓%s Official packages handled\n' "$green" "$reset"
    printf '  %s✓%s AUR packages handled\n' "$green" "$reset"
    printf '  %s✓%s Orphan cleanup handled\n' "$green" "$reset"
    printf '  %s✓%s Package cache handled\n' "$green" "$reset"
    printf '  %s✓%s System health checked\n' "$green" "$reset"
    printf '  %s✓%s Systemd logs handled\n' "$green" "$reset"

    printf '\n%sRecommended:%s\n' "$bold" "$reset"
    printf '  - Reboot if the kernel, systemd, Mesa, NVIDIA, or major desktop packages updated\n'
    printf '  - Review warnings above if anything was skipped\n'
    printf '  - Check the full log if something looked suspicious\n'

    printf '\nLog file:\n%s\n\n' "$log_file"
}

# ----------------------------------------------------------
# MAIN SCRIPT
# ----------------------------------------------------------

print_title
check_system
refresh_mirrors
check_arch_news
update_official_packages
update_aur_packages
clean_orphans
clean_package_cache
check_system_health
check_systemd_logs
finish_maintenance

