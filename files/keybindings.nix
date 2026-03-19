{
  home.file.".config/Cursor/User/keybindings.json".text = builtins.toJSON [
    {
      key = "shift+alt+cmd+c";
      command = "copyRelativeFilePath";
    }
  ];
}
