{ builders, nixpakModules, pkgs, ... }:

# Uses networking to download currency exchange rates
builders.mkNixPakPackage {
  config = {
    app.package = pkgs.gnome-calculator;
    flatpak.appId = "org.gnome.Calculator";
    imports = [
      nixpakModules.gui-base
    ];
  };
}
