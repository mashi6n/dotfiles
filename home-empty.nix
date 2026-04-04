{ pkgs, ... }:

{
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = [ ];

  home.file = { };
}
