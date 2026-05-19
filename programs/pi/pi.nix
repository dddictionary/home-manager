{ pkgs, lib, llm-agents ? null, system, ... }:

{
  home.packages = lib.optionals (llm-agents != null) [
    llm-agents.packages.${system}.pi
  ];

  home.file = {
    ".pi/agent/settings.json".source = ./settings.json;
    ".pi/agent/AGENTS.md".source = ./AGENTS.md;
    ".pi/agent/models.json".source = ./models.json;
    ".pi/agent/keybindings.json".source = ./keybindings.json;
    ".pi/agent/extensions".source = ./extensions;
    ".pi/agent/skills".source = ./skills;
    ".pi/agent/prompts".source = ./prompts;
    ".pi/agent/themes".source = ./themes;
  };
}
