{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.elixir;
in {
  options.modules.dev.elixir = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      erlang
      erlang-ls
      elixir
      elixir_ls
      inotify-tools # for live reload
    ];

    env.MIX_HOME        = "$XDG_CONFIG_HOME/mix";
    env.MIX_INSTALL_DIR = "$XDG_CACHE_HOME/mix";
  };
}
