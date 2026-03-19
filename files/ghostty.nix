{
  home.file.".config/ghostty/config".text = ''
    font-family = JetBrainsMono Nerd Font
    font-size = 12

    background-opacity = 1
    window-padding-x = 4
    window-padding-y = 4

    scrollback-limit = 10000

    theme = Cobalt2

    macos-option-as-alt = true

    keybind = cmd+t=new_tab
    keybind = cmd+w=close_tab
    keybind = cmd+shift+right_bracket=next_tab
    keybind = cmd+shift+left_bracket=previous_tab
    keybind = cmd+d=new_split:right
    keybind = cmd+shift+d=new_split:down
  '';
}
