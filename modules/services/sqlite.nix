{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.sqlite;
in {
  options.modules.services.sqlite = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ sqlite ];
  };
}
