{config, lib}:
with lib; {
  options.builders = mkOption {
    description = "Collection of builder functions.";
    type = with types; attrsOf (functionTo package);
    default = {};
  };

  mkNixPakPackage = args: let
    mkNixPak = inputs.nixpak.lib.nixpak {
      inherit (nixpkgs) lib;
      inherit pkgs;
    };
    pkg = mkNixPak args;
  in pkg.config.env;

  config._module.args = { inherit (config) builders; };
}
