{ config, lib, pkgs, ... }:

{
  config = lib.mkIf pkgs.stdenv.isLinux {
    programs.waybar = {
      enable = true;

      style = ''
        @define-color rosewater #f5e0dc;
        @define-color flamingo #f2cdcd;
        @define-color pink #f5c2e7;
        @define-color mauve #cba6f7;
        @define-color red #f38ba8;
        @define-color maroon #eba0ac;
        @define-color peach #fab387;
        @define-color yellow #f9e2af;
        @define-color green #a6e3a1;
        @define-color teal #94e2d5;
        @define-color sky #89dceb;
        @define-color sapphire #74c7ec;
        @define-color blue #89b4fa;
        @define-color lavender #b4befe;
        @define-color text #cdd6f4;
        @define-color subtext1 #bac2de;
        @define-color subtext0 #a6adc8;
        @define-color overlay2 #9399b2;
        @define-color overlay1 #7f849c;
        @define-color overlay0 #6c7086;
        @define-color surface2 #585b70;
        @define-color surface1 #45475a;
        @define-color surface0 #313244;
        @define-color base #1e1e2e;
        @define-color mantle #181825;
        @define-color crust #11111b;

        * {
          font-family: "Blex Mono Nerd Font", monospace;
          font-size: 14px;
          font-weight: bold;
        }

        window#waybar {
          background-color: @base;
          color: @text;
          border-bottom: 2px solid @surface0;
        }

        #workspaces button {
          color: @text;
          padding: 0 5px;
          border-radius: 0;
          border-bottom: 2px solid transparent;
        }

        #workspaces button.active {
          color: @lavender;
          border-bottom: 2px solid @lavender;
        }

        #workspaces button:hover {
          background: @surface0;
        }

        #clock,
        #battery,
        #cpu,
        #memory,
        #network,
        #pulseaudio,
        #tray {
          padding: 0 10px;
          color: @text;
        }

        #clock {
          color: @rosewater;
        }

        #battery {
          color: @green;
        }

        #battery.charging {
          color: @green;
        }

        #battery.warning:not(.charging) {
          color: @yellow;
        }

        #battery.critical:not(.charging) {
          color: @red;
        }

        #cpu {
          color: @sapphire;
        }

        #memory {
          color: @peach;
        }

        #network {
          color: @teal;
        }

        #network.disconnected {
          color: @red;
        }

        #pulseaudio {
          color: @mauve;
        }

        #pulseaudio.muted {
          color: @overlay0;
        }

        #tray {
          color: @text;
        }

        #custom-sleep {
          color: @lavender;
          padding: 0 8px;
        }

        #custom-logout {
          color: @peach;
          padding: 0 8px;
        }

        #custom-reboot {
          color: @yellow;
          padding: 0 8px;
        }

        #custom-shutdown {
          color: @red;
          padding: 0 8px;
        }
      '';

      settings = [{
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "cpu" "memory" "network" "tray" "custom/sleep" "custom/logout" "custom/reboot" "custom/shutdown" ];

        clock = {
          format = "{:%I:%M %p  %a %d %b}";
          tooltip-format = "{:%Y-%m-%d %I:%M %p}";
        };

        cpu = {
          format = " {usage}%";
          interval = 5;
        };

        memory = {
          format = " {percentage}%";
          interval = 5;
        };

        network = {
          format-wifi = " {signalStrength}%";
          format-ethernet = " {ifname}";
          format-disconnected = "󰖪 ";
          tooltip-format = "{ipaddr}/{cidr}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 muted";
          format-icons = {
            default = [ "" "" "" ];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        tray = {
          spacing = 10;
        };

        "hyprland/workspaces" = {
          format = "{id}";
        };

        "custom/sleep" = {
          format = "󰒲";
          tooltip = false;
          on-click = "systemctl suspend";
        };

        "custom/logout" = {
          format = "󰍃";
          tooltip = false;
          on-click = "hyprctl dispatch exit";
        };

        "custom/reboot" = {
          format = "󰜉";
          tooltip = false;
          on-click = "systemctl reboot";
        };

        "custom/shutdown" = {
          format = "⏻";
          tooltip = false;
          on-click = "systemctl poweroff";
        };
      }];
    };
  };
}
