{
  description = "NixPak Packages";
  inputs = {
    nixpak.url = "github:nixpak/nixpak";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpak/nixpkgs";
    };
    hercules-ci-effects = {
      url = "github:hercules-ci/hercules-ci-effects";
      inputs = {
        nixpkgs.follows = "nixpak/nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
  };
  outputs = { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } ({ withSystem, flake-parts-lib, ... }:
      let
        inherit (flake-parts-lib) importApply;
        nixosModules.default = importApply ./module.nix { localFlake = self; inherit withSystem; };
      in
      {
      imports = [
        inputs.hercules-ci-effects.flakeModule
        ./jobs/update-flake-lock
        # ./pkgs
        # ./part.nix
        # ./modules/builders.nix
      ];
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      # perSystem = { pkgs, ... }: {
      #   packages.default = nixosModules.default
      # };
      flake = { inherit nixosModules; };
  });
}
