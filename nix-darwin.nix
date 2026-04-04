{pkgs, ...}: {

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = "nix-command flakes";
    };
  };
  services.nix-daemon.enable = true;

  # system = {
  #   defaults = {
  #     NSGlobalDomain.AppleShowAllExtensions = true;
  #     finder = {
  #       AppleShowAllFiles = true;
  #       AppleShowAllExtensions = true;
  #     };
  #     dock = {
  #       autohide = true;
  #       show-recents = false;
  #       orientation = "bottom";
  #     };
  #   };
  # };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
    };
    casks = [
      "sublime-text"
    ];
  };
}
