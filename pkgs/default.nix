{ lib, config, pkgs, ... }:
{
  _module.args.nixpakModules = {
    gui-base = ./modules/gui-base.nix;
    network = ./modules/network.nix;
  };

  imports = [
    ./browsers/chromium
    ./gnome/calculator
    ./gnome/maps
    ./nonfree/discord.nix
    ./nonfree/spotify.nix
  ];
}
