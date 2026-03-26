{ config, pkgs, lib, nixvim-config ? null, system, self ? null, features ? [], username, homeDirectory, ... }:

{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.11";

  imports = [
    ./programs/git.nix
    ./programs/terminal.nix
    ./programs/tmux/tmux.nix
    ./programs/kitty/kitty.nix
    ./programs/zsh.nix
    ./programs/claude/claude.nix
    ./programs/linux
    ./files/gitignore.nix
    ./files/graphite.nix
    ./files/keybindings.nix
  ];

  # Powerlevel10k config — symlink to ~/.p10k.zsh
  home.file.".p10k.zsh".source = ./programs/p10k-config/p10k.zsh;

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
    zsh-powerlevel10k
    zsh-completions
  ]) ++ lib.optionals (nixvim-config != null) [
    nixvim-config.packages.${system}.default
  ];

  home.pointerCursor = lib.mkIf pkgs.stdenv.isLinux {
    name = "macOS";
    package = pkgs.apple-cursor;
    size = 24;
    gtk.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings.editor = "nvim";
  };
}
