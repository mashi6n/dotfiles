{ pkgs, ... }:

{
  home.packages = with pkgs; [
    uv
    pixi
    python314
  ];
}
