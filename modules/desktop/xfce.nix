{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.xfce;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.xfce = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    /* xserver = { */
    /*   enable = true; */
    /*   desktopManager = { */
    /*     xfce = { */
    /*       enable = true; */
    /*       noDesktop = true; */
    /*       enableXfwm = false; */
    /*     }; */
    /*   }; */
    /*   windowManager.bspwm.enable = true; */
    /*   displayManager.defaultSession = "xfce+bspwm"; */
    /* }; */
    services.xserver = {
      enable = true;
      desktopManager = {
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      windowManager.i3.enable = true;
      displayManager.defaultSession = "xfce+i3";
    };

    home.configFile = {
      "i3".source = "${configDir}/i3";
    };
  };
}
