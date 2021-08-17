{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let cfg = condig.modules.editors.emacs;
    configDir = config.dotfiles.configDir;
in {
  options.modules.editors.emacs = {
    enable = mkBoolOpt false;
    doom = {
      enable  = mkBoolOpt false;
      fromSSH = mkBoolOpt false;
    };
  };

  config = {
    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

    user.packages = with pkgs; [
      binutils
      # emacsPgtkGcc
      ((emacsPackagesNgGen emacsPgtkGcc).emacsWithPackages (epkgs: [
        epkgs.vterm
      ]))

      ## Doom dependencies
      git
      (ripgrep.override {withPCRE2 = true;})
      gnutls              # for TLS connectivity

      ## Optional dependencies
      fd                  # faster projectile indexing
      imagemagick         # for image-dired
      pinentry_emacs      # in-emacs gnupg prompts
      zstd                # for undo-fu-session/undo-tree compression
      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (ds: with ds; [
        en en-computers en-science
      ]))
      # :checkers grammar
      languagetool
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :lang cc
      ccls
      cmake
      gcc
      glslang

      # :lang nix
      nixfmt

      # :tools vterm
      gnumake
      libtool
    ];

    env.PATH = [ "XDG_CONFIG_HOME/emacs/bin" ];

    modules.shell.zsh.rcFiles = [ "${configDir}/emacs/aliases.zsh" ];

    fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];
  };
}
