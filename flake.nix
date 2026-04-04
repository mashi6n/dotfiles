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
  };

  # Flake outputs
  outputs =
    { self, home-manager, ... }@inputs:
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
      # Development environments output by this flake

      # To activate the default environment:
      # nix develop
      # Or if you use direnv:
      # direnv allow
      devShells = forEachSupportedSystem (
        { pkgs, system }:
        {
          # Run `nix develop` to activate this environment or `direnv allow` if you have direnv installed
          default = pkgs.mkShellNoCC {
            # The Nix packages provided in the environment
            packages = with pkgs; [
              # Add the flake's formatter to your project's environment
              self.formatter.${system}

              # Other packages
              ponysay
            ];

            # Set any environment variables for your development environment
            env = { };

            # Add any shell logic you want executed when the environment is activated
            shellHook = "";
          };
        }
      );

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
    };
}
