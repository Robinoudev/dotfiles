{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.plasma;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.plasma = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
        displayManager = {
          sddm.enable = true;
        };
        desktopManager.plasma5.enable = true;
      };
    };
  };
}
