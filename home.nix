{ config, pkgs, lib, nixvim-config ? null, llm-agents ? null, system, self ? null, features ? [], username, homeDirectory, ... }:

{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.11";

  imports = [
    ./programs/git.nix
    ./programs/terminal.nix
    ./programs/tmux/tmux.nix
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

  home.packages = (with pkgs; [
    ripgrep
    fd
    fzf
    jq
    bat
    zoxide
    tmux
    viddy
    glow
    git
    gh
    delta
    nodejs_22
    oxfmt
    python3
    ruby
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
  ]) ++ lib.optionals pkgs.stdenv.isDarwin (with pkgs; [
    pam-reattach
    spotify
  ]) ++ lib.optionals (nixvim-config != null) [
    nixvim-config.packages.${system}.default
  ];

  home.pointerCursor = lib.mkIf pkgs.stdenv.isLinux {
    name = "macOS";
    package = pkgs.apple-cursor;
    size = 24;
    gtk.enable = true;
  };

  gtk = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    theme = {
      name = "Kanagawa-BL";
      package = pkgs.kanagawa-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    platformTheme.name = "gtk";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
    KUBECONFIG = "${config.home.homeDirectory}/.kube/istaroth-config";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings.editor = "nvim";
  };

  # Let Nix authenticate GitHub fetches without putting the token in the Nix store.
  # The included file is generated locally from `gh auth token` during activation.
  xdg.configFile."nix/nix.conf".text = ''
    !include ${config.xdg.configHome}/nix/access-tokens.conf
  '';

  home.activation.writeNixGithubAccessToken = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
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
