{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    gopls
    gotools
    delve
  ];
  home.sessionPath = [
    "$HOME/go/bin"
  ];
}
