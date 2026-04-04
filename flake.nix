{
  description = "Basic Configuration Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, home-manager, nix-darwin, ... }@inputs:
    let
      lib = inputs.nixpkgs.lib;

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

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

      forEachSupportedSystem =
        f:
        lib.genAttrs supportedSystems (
          system:
          f {
            inherit system;
            pkgs = mkPkgs system;
            unstablePkgs = mkUnstablePkgs system;
          }
        );


      hosts = {
        mashi6n = {
          system = "aarch64-darwin";
          username = "mashi6n";
          homeDirectory = "/Users/mashi6n";
        };

        mashiro-toyooka = {
          system = "aarch64-darwin";
          username = "mashiro.toyooka";
          homeDirectory = "/Users/mashiro.toyooka";
        };

        ubuntu-x86_64 = {
          system = "x86_64-linux";
          username = "ubuntu";
          homeDirectory = "/home/ubuntu";
        };

        ubuntu-aarch64 = {
          system = "aarch64-linux";
          username = "ubuntu";
          homeDirectory = "/home/ubuntu";
        };
      };

      mkCommonHomeModules =
        { host, pkgs, homeFile }:
        [
          homeFile
          ./modules/shell.nix
          ./modules/nvim.nix
          ./modules/python.nix
          ./modules/util-tools.nix
          {
            home.username = host.username;
            home.homeDirectory = host.homeDirectory;
          }
        ]
        ++ lib.optionals pkgs.stdenv.isDarwin [
          ./modules/docker.nix
          ./modules/colima.nix
        ]
        ++ lib.optionals pkgs.stdenv.isLinux [
          ./modules/docker.nix
        ];

      mkHomeConfig =
        host: homeFile:
        let
          pkgs = mkPkgs host.system;
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            unstablePkgs = mkUnstablePkgs host.system;
          };
          modules = mkCommonHomeModules {
            inherit host pkgs homeFile;
          };
        };

      mkEmptyHomeConfig =
        host:
        let
          pkgs = mkPkgs host.system;
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home-empty.nix
            {
              home.username = host.username;
              home.homeDirectory = host.homeDirectory;
            }
          ];
        };

      mkDarwinConfig =
        host:
        nix-darwin.lib.darwinSystem {
          system = host.system;
          modules = [
            ./modules/nix-darwin.nix
          ];
        };
    in
    {
      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt);

      homeConfigurations = {
        mashi6n = mkHomeConfig hosts.mashi6n ./home.nix;
        "mashi6n-empty" = mkEmptyHomeConfig hosts.mashi6n;

        mashiro-toyooka = mkHomeConfig hosts.mashiro-toyooka ./home.nix;
        "mashiro-toyooka-empty" = mkEmptyHomeConfig hosts.mashiro-toyooka;

        ubuntu-x86_64 = mkHomeConfig hosts.ubuntu-x86_64 ./home.nix;
        "ubuntu-x86_64-empty" = mkEmptyHomeConfig hosts.ubuntu-x86_64;

        ubuntu-aarch64 = mkHomeConfig hosts.ubuntu-aarch64 ./home.nix;
        "ubuntu-aarch64-empty" = mkEmptyHomeConfig hosts.ubuntu-aarch64;
      };

      darwinConfigurations = {
        mashi6n = mkDarwinConfig hosts.mashi6n;
        mashiro-toyooka = mkDarwinConfig hosts.mashiro-toyooka;
      };
    };
}
