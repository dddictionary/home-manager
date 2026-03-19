# home-manager

Personal home-manager configuration for Abrar Habib.

This is the **personal layer** of a two-layer nix setup:
- **This repo**: portable personal config (shell, editor, tools)
- **dotnix**: work-specific config that layers on top

## Usage

### Standalone (personal machine)
```bash
nix run home-manager/master -- switch --flake .#abrar
```

### As a flake input (from dotnix)
```nix
inputs.personal-home-manager = {
  url = "github:dddictionary/home-manager";
};
```
