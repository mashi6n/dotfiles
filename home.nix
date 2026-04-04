{ pkgs, ... }:

{
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    bat
    ripgrep
    fzf
  ];
  home.file.".config/nvim".source = ./nvim;
  home.file.".config/alacritty".source = ./alacritty;
  home.file.".config/ghostty".source = ./ghostty;
  home.file.".config/bat".source = ./bat;
  home.file.".config/sheldon".source = ./sheldon;
  home.file.".config/karabiner".source = ./karabiner;
}
