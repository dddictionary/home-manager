# rose-pine moon theme for tmux
{ pkgs, ... }:
{
  plugin = pkgs.tmuxPlugins.rose-pine;
  extraConfig = ''
    set -g @rose_pine_variant 'moon'
    set -g @rose_pine_host 'off'
    set -g @rose_pine_user 'off'
    set -g @rose_pine_date_time '%Y-%m-%d %H:%M:%S'
    set -g @rose_pine_show_current_program 'on'
    set -g @rose_pine_show_pane_directory 'off'
  '';
}
