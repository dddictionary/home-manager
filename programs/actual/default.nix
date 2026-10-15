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

  # macOS reaches the server through `kubectl port-forward` (the public URL is
  # behind oauth2-proxy). No secrets here; the password comes from
  # ACTUAL_PASSWORD_FILE below.
  darwinConfig = builtins.toJSON {
    serverUrl = "http://localhost:5006";
    syncId = "bdb43d61-19f3-4b59-a073-0744b7cb8440";
    dataDir = "${config.home.homeDirectory}/.cache/actual-cli";
  };
in
{
  home.packages = lib.mkMerge [
    (lib.mkIf pkgs.stdenv.isLinux [ actualWrapper ])
    (lib.mkIf (!pkgs.stdenv.isLinux) [ actualCli ])
  ];

  home.file."Library/Preferences/actual/config.json" = lib.mkIf pkgs.stdenv.isDarwin {
    text = darwinConfig;
  };

  # TODO: drop the plaintext file. Copy the age key (age1hwgj…, see .sops.yaml)
  # to ~/.config/sops/age/keys.txt on this Mac, then have a wrapper on both
  # platforms run `sops decrypt --extract '["actual_password"]' ${./secrets.yaml}`
  # per invocation so the password never touches disk. Check secrets.yaml
  # still holds the current password first.
  programs.zsh.sessionVariables = lib.mkIf (!pkgs.stdenv.isLinux) {
    ACTUAL_PASSWORD_FILE = "$HOME/.config/actual-password";
  };

  sops = lib.mkIf pkgs.stdenv.isLinux {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      actual_sync_id = { };
      actual_password = { };
    };
  };
}
