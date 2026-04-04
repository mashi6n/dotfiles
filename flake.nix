{
  description = "An empty flake template that you can adapt to your own environment";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs
  outputs =
    { self, home-manager, nix-darwin, ... }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      forEachSupportedSystem =
        f:
        inputs.nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            inherit system;
            pkgs = import inputs.nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
            unstablePkgs = import inputs.nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          }
        );
      
      mkPkgs = 
        system:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      mkUnstablePkgs = 
        system:
        import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
    in
    {

      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt);

      homeConfigurations = {
          mashi6n = home-manager.lib.homeManagerConfiguration {
            pkgs = mkPkgs "aarch64-darwin";
            extraSpecialArgs = {
              unstablePkgs = mkUnstablePkgs "aarch64-darwin";
            };
            modules = [
              ./home.nix
              ./modules/git.nix
              ./modules/tmux.nix
              ./modules/shell.nix
              ./modules/docker.nix
              ./modules/colima.nix
              ./modules/nvim.nix
              {
                home.username = "mashi6n";
                home.homeDirectory = "/Users/mashi6n";
              }
            ];
          };

          mashi6n-empty = home-manager.lib.homeManagerConfiguration {
            pkgs = mkPkgs "aarch64-darwin";
            modules = [
              ./home-empty.nix
              {
                home.username = "mashi6n";
                home.homeDirectory = "/Users/mashi6n";
              }
            ];
          };
      };

      darwinConfigurations = {
          mashi6n = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [
              ./modules/nix-darwin.nix
            ];
          };
      };
    };
}
