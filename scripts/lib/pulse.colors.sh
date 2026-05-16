# ==========================================================
# FILE: scripts/lib/pulse-colors.sh
# ==========================================================
#
# PURPOSE
# -------
# Provide shared Pulse terminal colors for shell scripts.
#
# WHY IT EXISTS
# -------------
# Installer and setup scripts should use the same color palette
# instead of redefining colors in every file.
#
# HOW IT WORKS
# ------------
# This file defines ANSI escape sequences as shell variables.
#
# Other scripts can load it with:
#
# . scripts/lib/pulse-colors.sh
#
# FLOW
# ----
# Script starts
# -> loads this file
# -> uses Pulse color variables in printf output
#
# BEGINNER NOTES
# --------------
# These variables do not print anything by themselves.
#
# They are meant to be used inside printf commands.
#
# Example:
#
# printf "%bHello%b\n" "$PULSE_GREEN" "$PULSE_RESET"
#
# ==========================================================

# ----------------------------------------------------------
# TEXT RESET
# ----------------------------------------------------------

PULSE_RESET="$(printf '\033[0m')"

# ----------------------------------------------------------
# TEXT STYLES
# ----------------------------------------------------------

PULSE_BOLD="$(printf '\033[1m')"
PULSE_DIM="$(printf '\033[2m')"

# ----------------------------------------------------------
# BACKGROUND COLORS
# ----------------------------------------------------------

PULSE_BG="$(printf '\033[48;2;15;13;24m')"

# ----------------------------------------------------------
# FOREGROUND COLORS
# ----------------------------------------------------------

PULSE_FG="$(printf '\033[38;2;234;230;255m')"
PULSE_PURPLE="$(printf '\033[38;2;189;147;249m')"
PULSE_CYAN="$(printf '\033[38;2;139;233;253m')"
PULSE_GREEN="$(printf '\033[38;2;80;250;123m')"
PULSE_YELLOW="$(printf '\033[38;2;241;250;140m')"
PULSE_RED="$(printf '\033[38;2;255;85;85m')"
PULSE_PINK="$(printf '\033[38;2;255;121;198m')"
PULSE_MUTED="$(printf '\033[38;2;68;71;90m')"
