{ config, lib, pkgs, pkgs-unstable ? null, spicetify-nix ? null, ... }:

let
  spicePkgs = if spicetify-nix != null
    then spicetify-nix.legacyPackages.${pkgs.system}
    else null;
in
lib.mkIf pkgs.stdenv.isLinux {
  imports = lib.optionals (spicetify-nix != null) [
    spicetify-nix.homeManagerModules.default
  ];

  # NixOS switch aliases
  programs.zsh.shellAliases = {
    switch-home = "home-manager switch --flake ~/nixos/";
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
      teams-for-linux
      evince
      neofetch
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
    ++ lib.optionals (pkgs-unstable != null) (with pkgs-unstable; [
      postman
      vscode
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
}
