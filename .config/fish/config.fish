if status is-interactive
# Commands to run in interactive sessions can go here
  set -g fish_greeting	# disable fish greeting message
end

# ======================================================
# Pulse Colors
# ======================================================
set -U fish_color_normal C0CAF5
set -U fish_color_command 8BE9FD
set -U fish_color_keyword BD93F9
set -U fish_color_quote 50FA7B
set -U fish_color_redirection 7AA2F7
set -U fish_color_end FFB86C
set -U fish_color_error FF5555
set -U fish_color_param C0CAF5
set -U fish_color_comment 6B7394

set -U fish_color_selection --background=241C30
set -U fish_color_search_match --background=241C30

set -U fish_pager_color_completion C0CAF5
set -U fish_pager_color_description 6B7394
set -U fish_pager_color_prefix 8BE9FD
set -U fish_pager_color_selected_background --background=241C30

# ======================================================
# Starship Prompt
# ======================================================
starship init fish | source

# ======================================================
# ALIASES
# ======================================================
alias ls="lsd --long --all --header --git"
alias cat="bat"
alias nv="nvim"
alias lg="lazygit"
