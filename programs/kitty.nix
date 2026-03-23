{
  programs.kitty = {
    enable = true;

    font = {
      name = "Blex Mono Nerd Font";
      size = 12;
    };

    settings = {
      linux_display_server = "auto";
      cursor_shape = "beam";
      open_url_with = "firefox";
      detect_urls = true;
      allow_remote_control = "yes";
      editor = "nvim";
      tab_bar_edge = "top";
      tab_bar_style = "separator";
    };

    keybindings = {
      "ctrl+backspace" = "send_text all \\x17";
      "shift+enter" = "send_text all \\x1b[13;2u";
    };

    # kanagawabones theme via kitty's theme kitten
    extraConfig = ''
      include current-theme.conf
    '';
  };
}
