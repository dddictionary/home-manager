{ pkgs, ... }:

let
  colors = import ./themes/kanagawa-dragon.nix;
in
{
  home.file.".p10k.zsh".text = builtins.replaceStrings
    [
      "local grey='242'"
      "local red='#FF5C57'"
      "local yellow='#F3F99D'"
      "local blue='#57C7FF'"
      "local magenta='#FF6AC1'"
      "local cyan='#9AEDFE'"
      "local white='#F1F1F0'"
    ]
    [
      "local grey='${colors.grey}'"
      "local red='${colors.red}'"
      "local yellow='${colors.yellow}'"
      "local blue='${colors.blue}'"
      "local magenta='${colors.magenta}'"
      "local cyan='${colors.cyan}'"
      "local white='${colors.white}'"
    ]
    (builtins.readFile ./p10k.zsh);
}
