{ config, lib, ... }:

with lib;
{
  time.timeZone = mkDefault "Europe/Amsterdam";
  location = {
    latitude = 52.46083;
    longitude = 6.56528;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dvorak";
  };

  # Configure keymap in X11
  services.xserver = {
    autoRepeatDelay = 250;
    autoRepeatInterval = 50;
    layout = "us";
    xkbVariant = "dvorak";
    xkbOptions = "caps:swapescape";
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
