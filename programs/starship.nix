{
  programs.starship = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      add_newline = false;
      format = "$directory \${custom.git_branch_workaround}$git_status\n$character";
      command_timeout = 5000;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      directory = {
        truncation_length = 1;
        truncate_to_repo = true;
        style = "bold cyan";
      };
      git_branch = {
        disabled = true;
      };
      custom.git_branch_workaround = {
        command = "branch=$(git branch --show-current 2>/dev/null || echo HEAD); url=$(gh pr view --json url -q .url 2>/dev/null); [ -n \"$url\" ] && printf '\\033]8;;%s\\033\\\\%s\\033]8;;\\033\\\\' \"$url\" \"$branch\" || echo \"$branch\"";
        when = "git rev-parse --git-dir 2>/dev/null";
        format = " [$symbol$output]($style)";
        style = "bold purple";
        symbol = "🌱";
      };
      custom.git_worktree = {
        command = "d=$(basename $(pwd)); w=$(basename $(git rev-parse --show-toplevel) 2>/dev/null); [ \"$d\" != \"$w\" ] && echo \"$w\" || echo \"\"";
        when = "git rev-parse --is-inside-work-tree 2>/dev/null";
        format = " [$symbol$output]($style)";
        style = "bold yellow";
        symbol = "🌳";
      };
      git_status = {
        style = "bold yellow";
        conflicted = "⚔️";
        ahead = "⬆️ \${count}";
        behind = "⬇️ \${count}";
        diverged = "↕️ \${ahead_count}⇣\${behind_count}";
        untracked = "🆕";
        stashed = "📦";
        modified = "✏️";
        staged = "✅";
        renamed = "➡️";
        deleted = "🗑️";
      };
    };
  };
}
