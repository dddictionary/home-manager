{ pkgs, lib, config, ... }:

let
  actualCli = pkgs.callPackage ./actual-cli.nix { };

  actualServerUrl = "https://budget.4brar.me";

  actualWrapper = pkgs.writeShellScriptBin "actual" ''
    if [ -r "${config.sops.secrets.actual_sync_id.path}" ]; then
      export ACTUAL_SYNC_ID="$(cat ${config.sops.secrets.actual_sync_id.path})"
    fi
    if [ -r "${config.sops.secrets.actual_password.path}" ]; then
      export ACTUAL_PASSWORD="$(cat ${config.sops.secrets.actual_password.path})"
    fi
    export ACTUAL_SERVER_URL="${actualServerUrl}"
    exec ${actualCli}/bin/actual "$@"
  '';
in
{
  home.packages = lib.mkMerge [
    (lib.mkIf pkgs.stdenv.isLinux [ actualWrapper ])
    (lib.mkIf (!pkgs.stdenv.isLinux) [ actualCli ])
  ];

  sops = lib.mkIf pkgs.stdenv.isLinux {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      actual_sync_id = { };
      actual_password = { };
    };
  };
}
