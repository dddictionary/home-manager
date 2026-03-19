{ config, pkgs, lib, nixvim-config ? null, system, features ? [], homeDirectory, ... }:

{
  home.username = "abrar";
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.11";

  imports = [
    ./programs/git.nix
    ./programs/terminal.nix
    ./programs/tmux.nix
    ./programs/kitty.nix
    ./programs/zsh.nix
    ./programs/claude/claude.nix
    ./files/gitignore.nix
    ./files/graphite.nix
    ./files/keybindings.nix
  ];

  home.packages = (with pkgs; [
    ripgrep
    fd
    fzf
    jq
    bat
    eza
    zoxide
    tmux
    viddy
    glow
    git
    gh
    delta
    nodejs_20
    python3
    ruby
    btop
    ncdu
    curl
    wget
    httpie
    nerd-fonts.blex-mono
  ]) ++ lib.optionals (nixvim-config != null) [
    nixvim-config.packages.${system}.default
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}
