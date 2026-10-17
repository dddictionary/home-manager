{
  config,
  pkgs,
  lib,
  nixvim-config ? null,
  llm-agents ? null,
  system,
  self ? null,
  features ? [],
  username,
  homeDirectory,
  ...
}: let
  # helmfile apply/diff needs the helm-diff plugin. Wrap helm so the plugin is
  # on its pluginsDir, then build helmfile against that same wrapped helm.
  helm = pkgs.wrapHelm pkgs.kubernetes-helm {
    plugins = with pkgs.kubernetes-helmPlugins; [helm-diff];
  };
  helmfile = pkgs.helmfile-wrapped.override {inherit (helm) pluginsDir;};

  kanagawaGtkTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "kanagawa-gtk-theme";
    version = "0-unstable-2023-07-03";

    src = pkgs.fetchFromGitHub {
      owner = "Fausto-Korpsvart";
      repo = "Kanagawa-GKT-Theme";
      rev = "35936a1e3bbd329339991b29725fc1f67f192c1e";
      hash = "sha256-BZRmjVas8q6zsYbXFk4bCk5Ec/3liy9PQ8fqFGHAXe0=";
    };

    nativeBuildInputs = [pkgs.gtk3];

    installPhase = ''
      mkdir -p $out/share/themes
      cp -a themes/* $out/share/themes
    '';
  };
in {
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.11";

  imports = [
    ./programs/git.nix
    ./programs/terminal.nix
    ./programs/tmux/tmux.nix
    ./programs/herdr/herdr.nix
    ./programs/kitty/kitty.nix
    ./programs/fastfetch.nix
    ./programs/zsh.nix
    ./programs/yazi.nix
    ./programs/claude/claude.nix
    ./programs/pi/pi.nix
    ./programs/actual
    ./programs/linux
    ./files/gitignore.nix
    ./files/graphite.nix
    ./files/keybindings.nix
    ./programs/p10k
  ];

  home.packages =
    (with pkgs; [
      ripgrep
      fd
      fzf
      jq
      bat
      zoxide
      tmux
      viddy
      coreutils
      glow
      git
      gh
      delta
      nodejs_22
      oxfmt
      python3
      uv
      ruby
      go
      btop
      ncdu
      curl
      wget
      httpie
      dnsutils
      nerd-fonts.blex-mono
      zsh-powerlevel10k
      zsh-completions
      k9s
      kubectl
      age
      sops
      ssh-to-age
    ])
    ++ lib.optionals pkgs.stdenv.isDarwin (with pkgs; [
      pam-reattach
      spotify
    ])
    ++ lib.optionals (nixvim-config != null) [
      nixvim-config.packages.${system}.default
    ]
    ++ [
      helm
      helmfile
    ];

  home.pointerCursor = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    name = "macOS";
    package = pkgs.apple-cursor;
    size = 24;
    gtk.enable = true;
  };

  gtk = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    theme = {
      name = "Kanagawa-BL";
      package = kanagawaGtkTheme;
    };
    gtk4.theme = config.gtk.theme;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    platformTheme.name = "gtk3";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
    KUBECONFIG = "${config.home.homeDirectory}/.kube/config";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  nixpkgs.config.allowUnfree = true;

  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";

  # Textfox Firefox theme (module wired in flake.nix). Apply to the default-release
  # profile — that's the one profiles.ini marks as Default for this install.
  textfox = {
    enable = true;
    profiles = ["default-release"];
  };

  programs.home-manager.enable = true;

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings.editor = "nvim";
  };

  # Let Nix authenticate GitHub fetches without putting the token in the Nix store.
  # The included file is generated locally from `gh auth token` during activation.
  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
    !include ${config.xdg.configHome}/nix/access-tokens.conf
  '';

  home.activation.writeNixGithubAccessToken = lib.hm.dag.entryAfter ["writeBoundary"] ''
        token_file="${config.xdg.configHome}/nix/access-tokens.conf"
        mkdir -p "$(dirname "$token_file")"

        if token="$(${pkgs.gh}/bin/gh auth token 2>/dev/null)" && [ -n "$token" ]; then
          umask 077
          tmp_file="$token_file.tmp"
          printf 'access-tokens = github.com=%s\n' "$token" > "$tmp_file"
          mv "$tmp_file" "$token_file"
          chmod 600 "$token_file"
        elif [ ! -e "$token_file" ]; then
          umask 077
          cat > "$token_file" <<'EOF'
    # Run `gh auth login` and then `home-manager switch` to populate this file.
    EOF
          chmod 600 "$token_file"
        fi
  '';
}
