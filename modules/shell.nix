{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "ls -FG";
      ll = "ls -alFG";
      zed = "/Applications/Zed.app/Contents/MacOS/cli";
    };

    initContent = ''
      autoload -Uz colors && colors
      zstyle ':completion:*' menu select

      if [ -f "$HOME/.completion.d" ]; then
        source "$HOME/.completion.d"
      fi

      bindkey -e

      export TERM="xterm-256color"
    '';
  };
  home.file.".completion.d".source = ./../config/.completion.d;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.sheldon = {
    enable = true;
    enableZshIntegration = true;
  };
  xdg.configFile."sheldon/plugins.toml".text = ''
    shell = "zsh"

    [plugins.zsh-defer]
    github = "romkatv/zsh-defer"

    [templates]
    defer = "{{ hooks?.pre | nl }}{% for file in files %}zsh-defer source \"{{ file }}\"\n{% endfor %}{{ hooks?.post | nl }}"

    [plugins.compinit]
    inline = 'autoload -Uz compinit && compinit -C'

    [plugins.zsh-async]
    github = "mafredri/zsh-async"

    [plugins.zsh-completions]
    apply = ["defer"]
    github = "zsh-users/zsh-completions"

    [plugins.zsh-autosuggestions]
    apply = ["defer"]
    github = "zsh-users/zsh-autosuggestions"

    [plugins.zsh-syntax-highlighting]
    apply = ["defer"]
    github = "zsh-users/zsh-syntax-highlighting"

    [plugins.pure]
    github = "sindresorhus/pure"
  '';

  home.sessionVariables = {
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  ];

}
