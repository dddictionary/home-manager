{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;

    config = {
      global = {
        hide_env_diff = true;
        load_dotenv = true;
        warn_timeout = "30s";
      };
    };

    stdlib = ''
      use_node() {
        local version=''${1:-lts}
        if has nvm; then
          nvm use "$version"
        fi
      }

      use_python() {
        local version=''${1:-3}
        if has pyenv; then
          pyenv local "$version"
        fi
      }

      load_aliases() {
        local alias_file=".aliases"
        if [[ -f "$alias_file" ]]; then
          source "$alias_file"
        fi
      }
    '';
  };
}
