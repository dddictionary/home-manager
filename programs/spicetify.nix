{ config, lib, pkgs, spicetify-nix ? null, ... }:

let
  spicePkgs = if spicetify-nix != null
    then spicetify-nix.legacyPackages.${pkgs.system}
    else null;
in
{
  config = {
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
