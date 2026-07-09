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
#   - prefix + shift + 1..9 -> jump straight to a space by number
#   - prefix + shift + j/k  -> next / previous space
#   - prefix + w            -> fuzzy space picker (herdr default)
{
  xdg.configFile."herdr/config.toml".text = ''
    # Managed by home-manager (programs/herdr/herdr.nix). Do not edit by hand.
    onboarding = false

    [ui]
    agent_panel_sort = "spaces"

    [keys]
    prefix = "ctrl+a"

    # Tabs within a space (tmux windows)
    switch_tab = "prefix+1..9"
    new_tab = "prefix+c"
    next_tab = "prefix+n"
    previous_tab = "prefix+p"

    # Move across spaces (tmux sessions/workspaces)
    switch_workspace = "prefix+shift+1..9"
    next_workspace = "prefix+shift+j"
    previous_workspace = "prefix+shift+k"
    workspace_picker = "prefix+w"
    new_workspace = "prefix+shift+n"
  '';
}
