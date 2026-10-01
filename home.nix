{ config, pkgs, user, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in

{
  home.username = "willclark";
  home.homeDirectory = "/Users/willclark";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    ripgrep   # fast search
    fd        # fast find
    fzf       # fuzzy finder
    jq        # json on the command line
    lazygit
    neovim
    nerd-fonts.hack
    texlive.combined.scheme-full
    # quarto
    sioyek    # aliased into /Applications/Nix Apps by configuration.nix
  ];
  fonts.fontconfig.enable = true;
  home.sessionVariables.EDITOR = "nvim";

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;      # ghost text from history
    syntaxHighlighting.enable = true;  # commands turn green when valid
    initContent = ''
      bindkey '^f' autosuggest-accept
    '';
    shellAliases = {
      ".." = "cd ..";
      add = "git add .";
      push = "git push";
      pull = "git pull";
      m = "git switch main";
      cc = "claude --dangerously-skip-permissions";
      co = "codex --full-auto";
    };
  };

 programs.starship = {
  enable = true;
  settings = {
    add_newline = false;
    format = "$directory$git_branch$git_status$cmd_duration$line_break$character";

    # Prevent Starship from rendering python/conda env tags
    conda.disabled = true;
    python.disabled = true;

    directory = {
      style = "bold #ea9a97"; # Rose
      truncation_length = 3;
      truncate_to_repo = true;
      repo_root_style = "bold #ea9a97";
    };

    git_branch = {
      symbol = " ";
      style = "bold #c4a7e7"; # Iris
      format = "on [$symbol$branch]($style) ";
    };

    git_status = {
      style = "bold #eb6f92"; # Love
      format = "([$all_status$ahead_behind]($style) )";
    };

    cmd_duration = {
      format = "[$duration]($style) ";
      style = "bold #f6c177"; # Gold
    };

    character = {
      success_symbol = "[❯](bold #9ccfd8)"; # Foam
      error_symbol = "[❯](bold #eb6f92)";   # Love
    };
  };
};
  home.file.".config/ghostty".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/ghostty";
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/nvim";
  home.file.".config/herdr".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/herdr";
  home.file.".config/aerospace".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/aerospace";
  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.claude/settings.json";

  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  home.file.".codex/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  home.file.".config/opencode/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
}
