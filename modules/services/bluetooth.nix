{ options, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.bluetooth;
in {

  options.modules.services.bluetooth = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    # Enable A2DP Sink
    hardware.bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
}
