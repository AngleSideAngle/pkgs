{ inputs, ... }:
let
  inherit (inputs.nixpak.inputs) nixpkgs;
in
{
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
  perSystem = { pkgs, system, config, lib, ... }: {
    _module.args.pkgs = nixpkgs.legacyPackages.${system};

    options.builders = lib.mkOption {
      description = "Collection of builder functions.";
      type = with lib.types; attrsOf (functionTo package);
      default = {};
    };

    config._module.args = { inherit (config) builders; };

    builders.mkNixPakPackage = args: let
      mkNixPak = inputs.nixpak.lib.nixpak {
        inherit (nixpkgs) lib;
        inherit pkgs;
      };
      pkg = mkNixPak args;
    in pkg.config.env;

    imports = [
      ./pkgs
    ];
  };
}
