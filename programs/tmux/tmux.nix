{ pkgs, ... }:
let
  # Switch theme here: kanagawa or rose-pine-moon
  # theme = import ./themes/kanagawa.nix { inherit pkgs; };
  theme = import ./themes/rose-pine-moon.nix { inherit pkgs; };
in
{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    prefix = "C-a";
    keyMode = "vi";
    mouse = true;

    plugins = [ theme ];

    extraConfig = ''
      # Reload config
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind "'"
      unbind %

      # Switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Extended keys (Shift+Enter, Ctrl+Enter support)
      set -g extended-keys always
      set -g extended-keys-format csi-u
      set -as terminal-features 'xterm*:extkeys'

      # Vi copy mode bindings
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-alternative
      bind-key -T copy-mode-vi 'C-v' send -X rectangle-toggle

      # Status bar
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-interval 1
    '';
  };
}
