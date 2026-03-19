{
  home.file."Library/Application Support/Cursor/User/settings.json".text = builtins.toJSON {
    "editor.fontFamily" = "JetBrainsMono Nerd Font, Menlo, Monaco, 'Courier New', monospace";
    "editor.fontSize" = 14;
    "editor.lineHeight" = 1.5;
    "editor.fontLigatures" = true;

    "terminal.integrated.fontSize" = 12;
    "terminal.integrated.scrollback" = 10000;

    "workbench.colorTheme" = "Cobalt2";
    "workbench.iconTheme" = "material-icon-theme";

    "editor.formatOnSave" = true;
    "editor.tabSize" = 2;
    "editor.insertSpaces" = true;

    "git.autofetch" = true;
    "git.confirmSync" = false;
    "git.blame.editorDecoration.enabled" = true;
    "git.openRepositoryInParentFolders" = "always";

    "files.autoSave" = "afterDelay";
    "files.autoSaveDelay" = 1000;
    "files.trimTrailingWhitespace" = true;
    "files.trimFinalNewlines" = true;
    "files.insertFinalNewline" = true;

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
}
