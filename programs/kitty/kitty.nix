{ pkgs, ... }:
let
  # Switch theme here: kanagawabones or rose-pine-moon
  theme = import ./themes/kanagawabones.nix;
  # theme = import ./themes/rose-pine-moon.nix;
in
{
  programs.kitty = {
    enable = true;

    font = {
      name = "BlexMono Nerd Font Mono";
      size = if pkgs.stdenv.isDarwin then 16 else 12;
    };

    settings = {
      linux_display_server = "auto";
      cursor_shape = "beam";
      open_url_with = "firefox";
      detect_urls = true;
      allow_remote_control = "yes";
      editor = "nvim";

      # iTerm2-style tabs
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{index}: {title}";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";
    } // theme;

    keybindings = {
      "ctrl+backspace" = "send_text all \\x17";
      "shift+enter" = "send_text all \\x1b[13;2u";
      "super+w" = "close_tab";
      "super+t" = "new_tab";
      "super+1" = "goto_tab 1";
      "super+2" = "goto_tab 2";
      "super+3" = "goto_tab 3";
      "super+4" = "goto_tab 4";
      "super+5" = "goto_tab 5";
      "super+6" = "goto_tab 6";
      "super+7" = "goto_tab 7";
      "super+8" = "goto_tab 8";
      "super+9" = "goto_tab 9";
    };
  };
}
