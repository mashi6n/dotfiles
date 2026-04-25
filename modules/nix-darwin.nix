{ pkgs, user, ... }:
{

  nix = {
    enable = false;
  };
  # nix = {
  #   optimise.automatic = true;
  #   settings = {
  #     experimental-features = "nix-command flakes";
  #   };
  # };

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

  system = {
    stateVersion = 6;
    primaryUser = user;
  };

  homebrew = {
    enable = true;
    user = user;

    onActivation = {
      autoUpdate = true;
    };
    caskArgs = {
      appdir = "/Applications";
    };
    casks = [
      "ghostty"
      "visual-studio-code"
      "karabiner-elements"
      "raycast"
      "alt-tab"
      "google-chrome"
      "notion"
      "notion-calendar"
      "slack"
      "zed"
    ];
  };
}
