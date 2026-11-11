{ pkgs, ... }:

{
  # TeX Live from nixpkgs is the one distribution that builds on both macOS and
  # Linux (and Windows via WSL, since Nix has no native Windows support).
  home.packages = [
    (pkgs.texliveSmall.withPackages (ps: with ps; [
      collection-latexextra
      collection-fontsextra
      marvosym
      latexmk
    ]))
    pkgs.texlab
  ];
}
