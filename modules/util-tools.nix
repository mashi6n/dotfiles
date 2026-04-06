{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Mashiro Toyooka";
      user.email = "92073972+mashi6n@users.noreply.github.com";
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };

  programs.tmux = {
    enable = true;
  };
  home.file.".tmux.conf".source = ./../config/.tmux.conf;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    defaultCommand = "rg --files --hidden --glob '!.git'";
    defaultOptions = [
      "--height 40%"
      "--reverse"
      "--border"
      "--preview 'bat --style=numbers --color=always {}'"
    ];
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Mocha";
    };
  };

  home.packages = with pkgs; [
    ripgrep
    go-task
    curl
    wget
    cowsay
    lazygit
    gcloud
  ];

}
