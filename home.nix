{ pkgs, ... }:

{
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
  ];
  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/alacritty".source = ./config/alacritty;
  home.file.".config/ghostty".source = ./config/ghostty;
  home.file.".config/bat".source = ./config/bat;
  home.file.".config/karabiner".source = ./config/karabiner;
}
