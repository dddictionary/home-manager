# kanagawa dragon theme for tmux (via ukiyo plugin)
{ pkgs, ... }:
{
  plugin = pkgs.tmuxPlugins.ukiyo;
  extraConfig = ''
    set -g @ukiyo-theme "kanagawa/dragon"
    set -g @ukiyo-show-powerline true
    set -g @ukiyo-show-hostname false
    set -g @ukiyo-left-icon session
    set -g @ukiyo-show-timezone false
    set -g @ukiyo-military-time true
    set -g @ukiyo-time-format "%Y-%m-%d %H:%M:%S"
    set -g @ukiyo-plugins "time"
    set -g @ukiyo-show-flags true
  '';
}
