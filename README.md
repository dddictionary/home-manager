# home-manager

Personal home-manager configuration for Abrar Habib.

## Repo layout

```
home-manager/
├── flake.nix               # Flake inputs and homeConfigurations (linux, darwin)
├── home.nix                # Main module — imported by all configs
├── programs/
│   ├── git.nix
│   ├── zsh.nix
│   ├── terminal.nix
│   ├── tmux.nix
│   ├── kitty.nix
│   ├── linux-desktop.nix   # Linux-only packages, aliases, spicetify
│   └── claude/             # Claude Code config
└── files/
    ├── gitignore.nix
    ├── graphite.nix
    └── keybindings.nix
```

## Three-repo setup

| Repo | Purpose |
|------|---------|
| **[nixos](https://github.com/dddictionary/nixos)** | NixOS system configuration for the desktop |
| **home-manager** (this repo) | Personal home-manager config (shell, tools, packages) |
| **dotnix** (private) | Work-specific config layered on top of this repo |

## Usage

### Linux (NixOS desktop)

```bash
home-manager switch --flake ~/home-manager#linux
```

### macOS

```bash
home-manager switch --flake ~/home-manager#darwin
```

### First-time setup (no home-manager binary yet)

```bash
nix run github:nix-community/home-manager -- switch --flake ~/home-manager#linux
```

### As a flake input (from dotnix)

```nix
inputs.personal-home-manager.url = "github:dddictionary/home-manager";
```

Then import `"${personal-home-manager}/home.nix"` as a module.
