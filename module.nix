{ localFlake, withSystem, ... }:
{ lib, config, pkgs, ... }:
let
  inherit (localFlake.inputs.nixpak.inputs) nixpkgs;
in
{
  imports = [
    modules/builders.nix
    pkgs
  ];

  builders.mkNixPakPackage = args: let
    mkNixPak = localFlake.inputs.nixpak.lib.nixpak {
      inherit (nixpkgs) lib;
      inherit pkgs;
    };
    pkg = mkNixPak args;
  in pkg.config.env;
}
