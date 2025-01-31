{ builders, nixpakModules, pkgs, ... }:

{
  packages.discord = builders.mkNixPakPackage {
    config = {
      app.package = pkgs.spotify;
      flatpak.appId = "com.spotify.Spotify";
      imports = [
        nixpakModules.gui-base
        nixpakModules.network
      ];
    };
  };
}
