{ config, pkgs, lib, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "${./../files/fastfetch/logo.jpg}";
        type = "kitty";
        width = 40;
        padding.top = 1;
      };
      display = {
        separator = "  ";
      };
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "editor"
        "display"
        "lm"
        "wm"
        "theme"
        "icons"
        "font"
        "cursor"
        "terminal"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "localip"
        "locale"
        "break"
        "colors"
      ];
    };
  };
}
