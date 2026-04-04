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
}
