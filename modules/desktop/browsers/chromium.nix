{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.browsers.chromium;
in {
  options.modules.desktop.browsers.chromium = with types; {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      ungoogled-chromium
    ];
    programs.chromium = {
      enable = true;
      extensions = [
        "dpjamkmjmigaoobjbekmfgabipmfilij" # Empty new tab page
        "bkdgflcldnnnapblkhphbgpggdiikppg" # DuckDuckGo Privacy Essentials
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
        "njdfdhgcmkocbgbhcioffdbicglldapd" # LocalCDN
        "ckkdlimhmcjmikdlpkmbgfkaikojcbjk" # Markdown Viewer
      ];
    };
  };
}
