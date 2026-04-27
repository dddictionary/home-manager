{ config, lib, pkgs, ... }:

{
  config = lib.mkIf pkgs.stdenv.isLinux {

    wayland.windowManager.hyprland = {
      enable = true;
      # Use the NixOS-provided package to avoid building twice
      package = null;

      xwayland.enable = true;

      settings = {
        # Monitors
        monitor = [
          "DP-1, 1920x1080@239.76, 0x0, 1"
          "HDMI-A-1, 1920x1080@165, 1920x0, 1"
        ];

        # Programs
        "$terminal" = "kitty";
        "$fileManager" = "dolphin";
        "$menu" = "wofi --show drun";
        "$mainMod" = "SUPER";

        # Autostart
        exec-once = [
          "waybar & discord"
        ];

        # Environment variables
        env = [
          "XCURSOR_SIZE,24"
          "XCURSOR_THEME,macOS"
          "HYPRCURSOR_SIZE,24"
          "HYPRCURSOR_THEME,macOS"
          "LIBVA_DRIVER_NAME,nvidia"
          "XDG_SESSION_TYPE,wayland"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        ];

        cursor = {
          no_hardware_cursors = true;
        };

        # Look and feel
        general = {
          gaps_in = 0;
          gaps_out = 0;
          border_size = 1;
          "col.active_border" = "rgba(f5f2f2ff) rgba(4c5b68ff) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 0;
          rounding_power = 2;
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;

          bezier = [
            "easeOutQuint, 0.23, 1, 0.32, 1"
            "easeInOutCubic, 0.65, 0.05, 0.36, 1"
            "linear, 0, 0, 1, 1"
            "almostLinear, 0.5, 0.5, 0.75, 1"
            "quick, 0.15, 0, 0.1, 1"
            "instant, 0, 0, 1, 1"
          ];

          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 10, instant"
            "layersIn, 1, 10, instant"
            "layersOut, 1, 10, instant"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
            "zoomFactor, 1, 7, quick"
          ];
        };

        # Layouts
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = -1;
          disable_hyprland_logo = false;
        };

        # Input
        input = {
          kb_layout = "us";
          kb_options = "ctrl:nocaps";
          follow_mouse = 1;
          sensitivity = 0;

          touchpad = {
            natural_scroll = false;
          };
        };

        gesture = "3, horizontal, workspace";

        device = {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        };

        # Keybindings
        bind = [
          "$mainMod, Q, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, $menu"
          "$mainMod, P, pseudo,"
          "$mainMod, J, layoutmsg, togglesplit"
          ", PRINT, exec, hyprshot -m region -o ~/Pictures/Screenshots"
          "$mainMod, PRINT, exec, hyprshot -m output -o ~/Pictures/Screenshots"

          # Move focus
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Workspaces
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move windows to workspaces
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Move workspace to monitor
          "$mainMod SHIFT, LEFT, movecurrentworkspacetomonitor, -1"
          "$mainMod SHIFT, RIGHT, movecurrentworkspacetomonitor, +1"

          # Scratchpad
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          # Scroll workspaces
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];

        # Mouse bindings
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        # Media keys
        bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
          ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
        ];

        bindl = [
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];

        # Window rules
        windowrule = [
        ];
      };

      extraConfig = ''
        # Disable animations for wofi
        windowrule {
          name = no-anim-wofi
          match:class = wofi
          no_anim = on
        }

        # Fix some dragging issues with XWayland
        windowrule {
          name = windowrule-xwayland-fix
          no_focus = on
          match:class = ^$
          match:title = ^$
          match:xwayland = 1
          match:float = 1
          match:fullscreen = 0
          match:pin = 0
        }
      '';
    };

    # XDG portal configuration
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };

    services.hyprpaper.enable = true;

    xdg.configFile."hypr/hyprpaper.conf" = {
      force = true;
      onChange = "systemctl --user restart hyprpaper.service";
      text = ''
        wallpaper {
            monitor =
            path = /home/abrar/Pictures/wallpapers/wallhaven-lywpjl.jpg
            fit_mode = cover
        }

        ipc = true
        splash = false
      '';
    };

    # Supporting packages for Hyprland
    home.packages = with pkgs; [
      wofi
      hyprshot
      playerctl
      brightnessctl
      kdePackages.dolphin
      awww
    ];
  };
}
