{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
  };

  home.packages = with pkgs; [
    tmux
  ];

  home.file.".tmux.conf".source = ./../config/.tmux.conf;
}
