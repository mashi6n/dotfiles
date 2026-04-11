{ pkgs, ... }:

{
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.file.".config/alacritty".source = ./config/alacritty;
  home.file.".config/ghostty".source = ./config/ghostty;
  home.file.".config/karabiner".source = ./config/karabiner;
  home.file.".config/zed/settings.json".source = ./config/zed/settings.json;
}
