{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

  };

  home.packages = with pkgs; [
    neovim
  ];

  xdg.configFile."nvim".source = ./../config/nvim;
}
