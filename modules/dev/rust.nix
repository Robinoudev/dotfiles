{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.rust;
in {
  options.modules.dev.rust = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      rustc
      rustup
      rust-analyzer
    ];
  };
}
