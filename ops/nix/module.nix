{ config, lib, pkgs, ... }:
# Apache Superset is NOT packaged in nixpkgs — requires custom packaging
# Reference catalog: AbstractBike/machines catalog/apps/superset.nix
let
  cfg = config.abstractbike.superset;
in {
  options.abstractbike.superset = {
    enable = lib.mkEnableOption "AbstractBike Apache Superset (BI) profile";
    domain = lib.mkOption {
      type = lib.types.str;
      example = "superset.abstract.bike";
      description = "Public domain for Superset";
    };
    secretKeyFile = lib.mkOption {
      type = lib.types.path;
      description = "Path to file containing SECRET_KEY";
    };
    databaseUrlFile = lib.mkOption {
      type = lib.types.path;
      description = "Path to file containing SQLALCHEMY_DATABASE_URI";
    };
  };

  config = lib.mkIf cfg.enable {
    # TODO: package Superset for NixOS
    # Superset requires: Python env, Celery worker, Redis, PostgreSQL
    # See: https://github.com/apache/superset/tree/master/docker
    warnings = [ "abstractbike.superset: NixOS packaging not yet implemented. See ops/nix/module.nix." ];
  };
}
