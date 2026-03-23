{ config, lib, pkgs, ... }:

{
  config = lib.mkIf pkgs.stdenv.isLinux {
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
        nixfmt
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
  };
}
