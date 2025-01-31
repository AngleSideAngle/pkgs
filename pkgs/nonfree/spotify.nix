{ builders, nixpakModules, pkgs, ... }:

{
  packages.spotify = builders.mkNixPakPackage {
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
