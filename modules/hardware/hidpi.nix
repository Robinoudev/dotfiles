{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.hidpi;
in {
  options.modules.hardware.hidpi = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    # high-resolution display
    # hardware.video.hidpi.enable = lib.mkDefault true;

    # NOTE: the below are the only commands which hidpi sets
    console.font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";

    # Needed when typing in passwords for full disk encryption
    console.earlySetup = true;
    boot.loader.systemd-boot.consoleMode = "1";
    services.xserver.dpi = 146;

    # have a bigger cursor for hidpi
    environment.variables.XCURSOR_SIZE = "32";
  };
}
