# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, inputs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      inputs.nixos-hardware.nixosModules.common-pc-ssd
    ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    # Refuse ICMP echo requests on my desktop/laptop; nobody has any business
    # pinging them, unlike my servers.
    kernel.sysctl."net.ipv4.icmp_echo_ignore_broadcasts" = 1;
  };

  services.xserver.videoDrivers = ["nvidia"];

  nix.maxJobs = lib.mkDefault 8;
  hardware.cpu.amd.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "performance";

  # Power management
  environment.systemPackages = [ pkgs.acpi ];
  powerManagement.powertop.enable = true;

  # razer
  hardware.openrazer.enable = true;
  user.extraGroups = [ "plugdev" "openrazer" ];

  services.xserver.xrandrHeads = ["DP-4"];

  # audio
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  user.packages = with pkgs; [
    pavucontrol
    pamixer
    openrazer-daemon
  ];

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=nixos" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-label/swap"; }
    ];

  # high-resolution display
  # TODO(robin): For some reasen this makes gui apps way to big
  # set dpi myself?
  # hardware.video.hidpi.enable = lib.mkDefault true;
  # NOTE: the below are the only commands which hidpi sets
  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";

    # Needed when typing in passwords for full disk encryption
  console.earlySetup = true;
  boot.loader.systemd-boot.consoleMode = "1";
  services.xserver.dpi = 146;
}
