{ builders, nixpakModules, pkgs, ... }:

{
  packages.discord = builders.mkNixPakPackage {
    config = {
      app.package = pkgs.discord;
      flatpak.appId = "com.discordapp.Discord";
      imports = [
        nixpakModules.gui-base
        nixpakModules.network
      ];
    };
  };
}
