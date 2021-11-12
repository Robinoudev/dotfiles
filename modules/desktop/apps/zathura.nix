{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.zathura;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.apps.zathura = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      zathura
    ];

    home.configFile = {
      "zathura".source = "${configDir}/zathura";
    };
  };
}
