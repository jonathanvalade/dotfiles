{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    hostname = "jos-macbook-pro";
    computerName = "Jo's MacBook Pro";
  in {

    darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = { inherit hostname computerName; };
      modules = [
        ./default.nix
        nix-homebrew.darwinModules.nix-homebrew
      ];
    };

    darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
  };
}
