{ config, lib, pkgs, ... }:

{
  config = lib.mkIf pkgs.stdenv.isLinux {
    programs.zsh.initContent = lib.mkAfter ''
      # Map desktop name -> home-manager flake target
      # NixOS always uses the single "nixos" target — swap desktop by editing imports in configuration.nix
      _switch_resolve() {
        local desktop="''${1:-hyprland}"
        case "$desktop" in
          plasma)   _SWITCH_HM="linux" ;;
          hyprland) _SWITCH_HM="hyprland" ;;
          *)
            echo "Unknown desktop: $desktop"
            echo "Available: plasma, hyprland"
            return 1
            ;;
        esac
      }

      switch-nix() {
        echo "Rebuilding NixOS..."
        sudo nixos-rebuild switch --flake ~/nixos/#nixos
      }

      switch-home() {
        _switch_resolve "''${1:-hyprland}" || return 1
        echo "Rebuilding home-manager [$_SWITCH_HM]..."
        home-manager switch --flake ~/home-manager#"$_SWITCH_HM"
      }

      switch() {
        _switch_resolve "''${1:-hyprland}" || return 1
        echo "Switching to $1 (home-manager=$_SWITCH_HM)..."
        switch-home "$1" && switch-nix
      }
    '';
  };
}
