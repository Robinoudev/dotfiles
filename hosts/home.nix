{ config, lib, ... }:

{
  with lib;
  {
    time.timeZone = mkDefault "Europe/Amsterdam"
  }
}
