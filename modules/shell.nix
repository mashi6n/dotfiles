{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "ls -FG";
      ll = "ls -alFG";
      python = "python3";
      mp = "multipass";
    };

    initExtra = ''
      eval "$(sheldon source)"

      autoload -Uz colors && colors
      zstyle ':completion:*' menu select

      if [ -f "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
      fi

      if [ -f "$HOME/dotfiles/.completion.d" ]; then
        source "$HOME/dotfiles/.completion.d"
      fi

      bindkey -e

      if type rg >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
      fi
      if type fd >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='fd'
      fi

      export TERM="xterm-256color"
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.sessionVariables = {
    GOPATH = "$HOME/go";
    EDITOR = "vim";
    FZF_DEFAULT_OPTS = "--height 40% --reverse --border";
    BAT_THEME = "Catppuccin Mocha";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    "$HOME/.nodebrew/current/bin"
    "/usr/local/go/bin"
    "$HOME/go/bin"
  ];

  home.packages = with pkgs; [
    zsh
    sheldon
    direnv
  ];
}
