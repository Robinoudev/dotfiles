{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.vim;
    configDir = config.dotfiles.configDir;
in {
  options.modules.editors.vim = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      editorconfig-core-c
      unstable.neovim
      tree-sitter
    ];

    home.configFile = {
      "nvim" = { source = "${configDir}/nvim"; recursive = true; };
    };

    environment.shellAliases = {
      vim = "nvim";
      v   = "nvim";
    };
  };
}
