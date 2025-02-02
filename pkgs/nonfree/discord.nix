{ builders, nixpakModules, pkgs, ... }:

builders.mkNixPakPackage {
  config = {
    app.package = pkgs.discord;
    flatpak.appId = "com.discordapp.Discord";
    imports = [
      nixpakModules.gui-base
      nixpakModules.network
    ];
  };
}
