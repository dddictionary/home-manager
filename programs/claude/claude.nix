{ pkgs, ... }:
{
  programs.claude-code = {
    enable = true;
    settings = {
      model = "claude-opus-4-7";
      promptSuggestionEnabled = false;
      statusLine = {
        type = "command";
        command = "claude-statusline";
      };
      fileSuggestion = {
        type = "command";
        command = "claude-file-suggestion";
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
