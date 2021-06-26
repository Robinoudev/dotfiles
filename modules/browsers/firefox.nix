{ config, lib, pkgs, ... }:

{
  environment = {
    sessionVariables = {
      BROWSER = "firefox";
      XDG_DESKTOP_DIR = "$HOME";
    };

    systemPackages = with pkgs; [
      firefox
    ];
  };
}
