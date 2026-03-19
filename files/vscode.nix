{
  programs.vscode = {
    enable = true;
    profiles.default.userSettings = {
      "editor.fontFamily" = "JetBrainsMono Nerd Font, Menlo, Monaco, 'Courier New', monospace";
      "editor.fontSize" = 12;
      "editor.lineHeight" = 1.5;
      "editor.fontLigatures" = true;
      "editor.accessibilitySupport" = "off";

      "terminal.integrated.fontSize" = 12;
      "terminal.integrated.scrollback" = 10000;

      "workbench.colorTheme" = "Cobalt2";
      "workbench.iconTheme" = "material-icon-theme";

      "window.zoomLevel" = -1;
      "window.zoomPerWindow" = false;
      "window.title" = "\${rootName}\${separator}\${activeEditorShort}\${separator}\${dirty}";

      "explorer.confirmDelete" = false;

      "editor.formatOnSave" = true;
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;

      "git.autofetch" = false;
      "git.confirmSync" = false;
      "git.blame.editorDecoration.enabled" = true;
      "git.openRepositoryInParentFolders" = "always";

      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = false;
      "files.trimTrailingWhitespace" = true;
      "files.trimFinalNewlines" = true;
      "files.insertFinalNewline" = true;

      "files.watcherExclude" = {
        "**/.git/objects/**" = true;
        "**/.git/subtree-cache/**" = true;
        "**/node_modules/**" = true;
        "**/vendor/**" = true;
        "backup/**" = true;
        "bin/**" = true;
        "cache/**" = true;
        "images/**" = true;
        "logs/**" = true;
        "system/**" = true;
        "tmp/**" = true;
        "webserver-configs/**" = true;
        "**/build/**" = true;
        "**/dist/**" = true;
        "**/out/**" = true;
        "**/coverage/**" = true;
        "**/.next/**" = true;
        "**/.nuxt/**" = true;
        "**/.turbo/**" = true;
        "**/.swc/**" = true;
        "**/.parcel-cache/**" = true;
        "**/.vite/**" = true;
        "**/.yarn/**" = true;
        "**/.pnpm-store/**" = true;
        "**/target/**" = true;
        "**/__pycache__/**" = true;
        "**/.pytest_cache/**" = true;
        "**/.rspec_cache/**" = true;
        "**/public/packs/**" = true;
        "**/public/build/**" = true;
        "**/uploads/**" = true;
        "**/storage/**" = true;
      };

      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[markdown]" = {
        "editor.wordWrap" = "on";
        "files.trimTrailingWhitespace" = false;
      };

      "devTestRunner.testCommand" = "pnpm run test";
      "devTestRunner.testCommandArgs" = ["--watch"];
    };
  };
}
