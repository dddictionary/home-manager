{ config, lib, pkgs, spicetify-nix ? null, ... }:

let
  spicePkgs = if spicetify-nix != null
    then spicetify-nix.legacyPackages.${pkgs.system}
    else null;
in
{
  config = lib.mkIf pkgs.stdenv.isLinux {

  # NixOS switch aliases
  programs.zsh.shellAliases = {
    switch-home = "home-manager switch --flake ~/home-manager#linux";
    switch-nix = "sudo nixos-rebuild switch --flake ~/nixos/#nixos";
    switch-both = "switch-home && switch-nix";
  };

  # Linux desktop packages
  home.packages =
    (with pkgs; [
      # Desktop apps
      racket
      mpv
      vlc
      (discord-canary.override {
        withOpenASAR = true;
        withVencord = true;
      })
      evince
      fastfetch
      vesktop
      zoom-us
      styluslabs-write-bin
      texliveFull
      texstudio
      libreoffice
      obs-studio
      chromium
      gparted

      # Extra dev tools
      nixfmt-classic
      rustlings
      python311Packages.pygments
      tree
      unzip
      pandoc
      aoc-cli
    ])
    ++ (with pkgs; [
      postman
      ani-cli
      zed-editor
    ]);

  # Spicetify (Spotify theming)
  programs.spicetify = lib.mkIf (spicePkgs != null) {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      shuffle
    ];
    theme = spicePkgs.themes.onepunch;
    colorScheme = "dark";
  };
  };
}
