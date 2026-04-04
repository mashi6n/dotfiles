set -eux

nix run .#homeConfigurations.mashi6n.activationPackage
nix run nix-darwin -- switch --flake .#mashi6n
