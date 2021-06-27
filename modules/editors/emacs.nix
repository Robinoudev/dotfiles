{ config, lib, pkgs, ... }:

{
  # use emacs-overlay for bleeding edge emacs
  # services.emacs.package = pkgs.emacsUnstable;
  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  #   }))
  # ];

  environment.systemPackages = with pkgs; [
    binutils
    emacs
    # emacsPgtkGcc

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
  ];
}
