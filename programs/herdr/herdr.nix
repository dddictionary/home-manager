{ ... }:
# herdr (agent multiplexer) config.
#
# The herdr *package* is provided by the flake's herdrModule; this file just
# manages ~/.config/herdr/config.toml declaratively.
#
# Terminology: a "space" in the sidebar is a workspace; each space holds tabs.
# tmux muscle-memory mapping:
#   - prefix = ctrl+a (same as tmux.nix)
#   - prefix + 1..9        -> switch tab within the current space (like tmux windows)
#   - prefix + w            -> fuzzy space picker: jump to ANY space (type to filter)
#   - prefix + shift + j/k  -> next / previous space
#
# NOTE: we deliberately do NOT bind "prefix+shift+1..9" for spaces. Shift+number
# produces symbols (!@#...) whose mapping is terminal/keyboard-layout dependent,
# so it fires unreliably. Use the picker (prefix+w) to jump to a space by name.
# shift+LETTER chords are reliable in prefix mode (herdr's own defaults use them).
{
  xdg.configFile."herdr/config.toml".text = ''
    # Managed by home-manager (programs/herdr/herdr.nix). Do not edit by hand.
    onboarding = false

    [ui]
    agent_panel_sort = "spaces"

    [keys]
    prefix = "ctrl+a"

    # Pane splits
    split_vertical = "prefix+|"       # split right (prefix + shift + \)
    split_horizontal = "prefix+minus" # split below

    # Tabs within a space (tmux windows)
    switch_tab = "prefix+1..9"
    new_tab = "prefix+c"
    next_tab = "prefix+n"
    previous_tab = "prefix+p"

    # Move across spaces (tmux sessions/workspaces)
    workspace_picker = "prefix+w"       # jump to any space, type to filter
    next_workspace = "prefix+shift+j"   # cycle to next space
    previous_workspace = "prefix+shift+k" # cycle to previous space
    new_workspace = "prefix+shift+n"

    # Render inline images (kitty graphics protocol) from agents / icat.
    # Experimental + off by default in herdr; required for images to show
    # through the multiplexer. Host terminal (kitty) already supports it.
    [experimental]
    kitty_graphics = true
  '';
}
