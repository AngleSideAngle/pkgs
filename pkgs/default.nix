{ localFlake, withSystem, ... }:
{ lib, config, pkgs, ... }:
let
  inherit (localFlake.inputs.nixpak.inputs) nixpkgs;
in
{
  builders.mkNixPakPackage = args: let
    mkNixPak = localFlake.inputs.nixpak.lib.nixpak {
      inherit (nixpkgs) lib;
      inherit pkgs;
    };
    pkg = mkNixPak args;
  in pkg.config.env;

  _module.args.nixpakModules = {
    gui-base = ./modules/gui-base.nix;
    network = ./modules/network.nix;
  };

  imports = [
    ../modules/builders.nix
    ./browsers/chromium
    ./gnome/calculator
    ./gnome/maps
    ./nonfree/discord.nix
    ./nonfree/spotify.nix
  ];
}
