# Dotfiles

Personal Linux desktop and terminal configuration.

This repository allows me to quickly rebuild my full environment after a fresh install.

It includes:

- Shell configuration
- Terminal tooling
- Git tooling
- Desktop theming
- Wayland configuration
- Browser styling
- Wallpapers
- Pulse theme customization

My Neovim configuration lives in a separate repository.

---

## Philosophy

I prefer rebuilding systems quickly without manually reconfiguring everything.

The goal:

Fresh install → clone repo → restore workflow → get back to building.

This repo prioritizes:

- Fast terminal workflows
- Desktop consistency
- Strong theming cohesion
- Minimal manual setup
- Easy portability

---

## Installation

```
curl -fsSL https://raw.githubusercontent.com/anhthevo1989/dotfiles/main/install.sh | sh
```

---

# Repository Structure

```
dotfiles/
├── .bashrc
├── .gitconfig
├── README.md
├── .config
│   ├── bat
│   │   ├── config
│   │   └── themes
│   │       └── Pulse.tmTheme
│   │
│   ├── DankMaterialShell
│   │   ├── .changelog-1.4
│   │   ├── .firstlaunch
│   │   ├── firefox.css
│   │   ├── settings.json
│   │   └── themes
│   │       └── pulse.json
│   │
│   ├── environment.d
│   │   ├── 90-dms.conf
│   │   └── qt.conf
│   │
│   ├── fish
│   │   ├── completions
│   │   ├── conf.d
│   │   ├── config.fish
│   │   ├── fish_variables
│   │   └── functions
│   │
│   ├── gtk-3.0
│   │   ├── dank-colors.css
│   │   └── gtk.css -> dank-colors.css
│   │
│   ├── gtk-4.0
│   │   ├── dank-colors.css
│   │   └── gtk.css
│   │
│   ├── hypr
│   │   ├── hyprland.lua
│   │   ├── dms
│   │   │   ├── layout.conf
│   │   │   └── windowrules.conf
│   │   └── lua
│   │       └── modules
│   │           ├── animations.lua
│   │           ├── autostart.lua
│   │           ├── binds.lua
│   │           ├── decoration.lua
│   │           ├── env.lua
│   │           ├── input.lua
│   │           ├── layouts.lua
│   │           ├── monitors.lua
│   │           ├── pulse.lua
│   │           └── rules.lua
│   │
│   ├── kitty
│   │   ├── kitty.conf
│   │   ├── kitty.conf.bak
│   │   ├── dank-theme.conf
│   │   └── dank-tabs.conf
│   │
│   ├── lazygit
│   │   └── config.yml
│   │
│   ├── lsd
│   │   ├── config.yaml
│   │   └── colors.yaml
│   │
│   ├── mozilla
│   │   └── firefox
│   │       └── chrome
│   │           ├── userChrome.css
│   │           └── userContent.css
│   │
│   ├── pacseek
│   │   ├── config.json
│   │   └── colors.json
│   │
│   ├── qt5ct
│   │   ├── qt5ct.conf
│   │   └── colors
│   │       └── matugen.conf
│   │
│   ├── qt6ct
│   │   ├── qt6ct.conf
│   │   ├── qss
│   │   └── colors
│   │       ├── matugen.conf
│   │       └── pulse.conf
│   │
│   ├── starship.toml
│   │
│   └── xdg-desktop-portal
│       └── hyprland-portals.conf
│
└── wallpapers
    ├── pulse.png
    └── archlinux-pulse.png
