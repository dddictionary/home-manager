{ config, lib, pkgs, ... }:

{
  config = lib.mkIf pkgs.stdenv.isLinux {
    home.packages =
      (with pkgs; [
        # Desktop apps
        racket
        mpv
        vlc
        spotify
        (discord-canary.override {
          withOpenASAR = true;
          withVencord = true;
        })
        evince
        vesktop
        zoom-us
        styluslabs-write-bin
        texliveFull
        texstudio
        libreoffice
        obs-studio
        chromium
        gparted
        overskride
        thunar
        thunar-volman
        thunar-archive-plugin
        tumbler
        gvfs

        # Extra dev tools
        nixfmt
        rustlings
        python311Packages.pygments
        tree
        unzip
        pandoc
        aoc-cli
        gnumake

        # Games
        prismlauncher
      ])
      ++ (with pkgs; [
        postman
        ani-cli
        zed-editor
      ]);
  };
}
