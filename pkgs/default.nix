{ localFlake, withSystem, ... }:
{ lib, config, pkgs, ... }:
let
  inherit (localFlake.inputs.nixpak.inputs) nixpkgs;
in
{
  imports = [ ../modules/builders.nix ];

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

  packages = {
    chromium = ./browsers/chromium;
    calculator = ./gnome/calculator;
    maps = ./gnome/maps;
    discord = ./nonfree/discord.nix;
    spotify = ./nonfree/spotify.nix;
  };
}
