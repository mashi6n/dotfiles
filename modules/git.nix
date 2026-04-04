{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Mashiro Toyooka";
    userEmail = "92073972+mashi6n@users.noreply.github.com";

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };
}
