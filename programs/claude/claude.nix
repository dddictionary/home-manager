{ pkgs, ... }:
{
  programs.claude-code = {
    enable = true;
    settings = {
      model = "opus";
      alwaysThinkingEnabled = false;
      promptSuggestionEnabled = false;
      enabledPlugins = { };
      statusLine = {
        type = "command";
        command = "claude-statusline";
      };
      fileSuggestion = {
        type = "command";
        command = "claude-file-suggestion";
      };
      hooks = {
        Notification = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "osascript -e 'if application \"iTerm\" is not frontmost then display notification \"Claude needs your input\" with title \"Claude Code\" sound name \"Ping\"'";
              }
            ];
          }
        ];
        Stop = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "osascript -e 'if application \"iTerm\" is not frontmost then display notification \"Claude has finished and is waiting for you\" with title \"Claude Code\" sound name \"Ping\"'";
              }
            ];
          }
        ];
      };
    };
  };

  home.packages = with pkgs; [
    (writeScriptBin "claude-statusline" (builtins.readFile ./claude-statusline.rb))
    (writeScriptBin "claude-file-suggestion" (builtins.readFile ./file-suggestion.sh))
  ];

  programs.git.ignores = [
    "CLAUDE.local.md"
  ];
}
