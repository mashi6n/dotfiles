{pkgs, user, ...}: {
  nix = {
    enable = false;
  };
  system = {
    stateVersion = 6;
    primaryUser = user;
  };
}

