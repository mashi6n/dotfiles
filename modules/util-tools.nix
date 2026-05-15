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
    keyMode = "vi";
    extraConfig = ''
      # 基本設定
      ## 256色端末を使用する
      set -g default-terminal "tmux-256color"
      set -g terminal-overrides ',*:Tc'
      ## Escキーの遅延を解消
      set -s escape-time 0
      ## status line を更新する間隔を1秒にする
      set-option -g status-interval 1
      ## ウィンドウのインデックスを1から始める
      set -g base-index 1
      ## ペインのインデックスを1から始める
      setw -g pane-base-index 1
      set -g window-style 'bg=#161621'
      set -g window-active-style 'bg=#1e1e2e'
      
      ## prefix + -で水平分割
      bind - split-window -v
      ## prefix + |で垂直分割
      bind | split-window -h
      
      # vimのキーバインドでペインを移動する
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      ## コマンドモードでの選択方法をvim風に変更
      set-window-option -g mode-keys vi
      setw -g mode-keys vi
      bind-key -T copy-mode-vi v send -X begin-selection
      
      set-option -g history-limit 5000
    '';
  };

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
    google-cloud-sdk
  ];

}
