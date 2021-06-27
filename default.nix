# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

with lib;
{
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
    ];

  # TODO: config.dotfiles does not exist
  environment.variables.DOTFILES = config.dotfiles.dir;
  environment.variables.DOTFILES_BIN = config.dotfiles.binDir;

  # Default boot options for all machines
  boot = {
    loader = {
      efi.canTouchEfiVariables = mkDefault true;
      systemd-boot.configurationLimit = 10;
      systemd-boot.enable = mkDefault true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.robin = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "audio" ]; # Enable ‘sudo’ for the user.
  };

  # Bare necessary packages
  environment.systemPackages = with pkgs; [
    bind
    coreutils
    git
    vim 
    wget
    unzip
    bc
    # Mounting different filesystems
    bashmount
    sshfs
    exfat
    ntfs3g
    hfsprogs
  ];

  environment.variables.NIXPKGS_ALLOW_UNFREE = "1";

  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "21.05"; # Did you read the comment?
}
