{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.postgresql;
in {
  options.modules.services.postgresql = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_13;
    };
  };
}
