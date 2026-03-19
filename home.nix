{ config, pkgs, lib, features ? [], homeDirectory, ... }:

{
  home.username = "abrar";
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.11";

  imports = [
    ./programs/git.nix
    ./programs/starship.nix
    ./programs/terminal.nix
    ./programs/tmux.nix
    ./programs/direnv.nix
    ./programs/zsh.nix
    ./programs/vscode.nix
    ./files/ghostty.nix
    ./files/cursor.nix
    ./files/gitignore.nix
    ./files/graphite.nix
    ./files/keybindings.nix
  ];

  home.packages = with pkgs; [
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
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.home-manager.enable = true;
}
