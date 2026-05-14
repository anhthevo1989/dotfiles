#!/bin/sh
set -eu

if [ "${DEBUG:-0}" = "1" ]; then
    set -x
fi

# ==========================================================
# FILE: install.sh
# ==========================================================
#
# PURPOSE
# -------
# Clone dotfiles into ~/Projects and symlink configs into
# their correct locations.
#
# WHY IT EXISTS
# -------------
# Rebuilding a system should be fast and repeatable.
#
# HOW IT WORKS
# ------------
# Clones repo
# -> backs up existing configs
# -> creates symlinks
#
# FLOW
# ----
# Run script
# -> clone repo
# -> link files
# -> done
#
# BEGINNER NOTES
# --------------
# Symlinks let you edit files inside the repo while your
# system continues using them.
#
# ==========================================================

# ----------------------------------------------------------
# CONFIGURATION
# ----------------------------------------------------------

repo_url="https://github.com/anhthevo1989/dotfiles.git"
projects_dir="$HOME/Projects"
repo_dir="$projects_dir/dotfiles"
backup_dir="$HOME/.dotfiles-backup"

# ----------------------------------------------------------
# COLORS
# ----------------------------------------------------------

reset="$(printf '\033[0m')"
green="$(printf '\033[32m')"
blue="$(printf '\033[34m')"

# ----------------------------------------------------------
# UI HELPERS
# ----------------------------------------------------------

print_step() {
    current_step=$((current_step + 1))
}

# ----------------------------------------------------------
# BACKUP HELPERS
# ----------------------------------------------------------

backup_existing_path() {
    target_path="$1"
}

# ----------------------------------------------------------
# SYMLINK HELPERS
# ----------------------------------------------------------

link_repo_path() {
    source_path="$1"
    target_path="$2"
}

# ----------------------------------------------------------
# MAIN SCRIPT
# ----------------------------------------------------------

printf "Installing dotfiles...\n"
