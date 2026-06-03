{ pkgs, lib, llm-agents ? null, system, ... }:

{
  home.packages = lib.optionals (llm-agents != null) [
    llm-agents.packages.${system}.pi
  ];
}
