{ config, lib, inputs, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x220
    ];

  boot = {
    initrd.availableKernelModules = [ "ehci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    # Refuse ICMP echo requests on my desktop/laptop; nobody has any business
    # pinging them, unlike my servers.
    kernel.sysctl."net.ipv4.icmp_echo_ignore_broadcasts" = 1;
  };

  # Modules
  modules.hardware = {
    audio.enable = true;
  };

  # CPU
  nix.maxJobs = lib.mkDefault 8;
  hardware.cpu.intel.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "performance";

  # Power management
  environment.systemPackages = [ pkgs.acpi ];
  powerManagement.powertop.enable = true;
  # Monitor backlight control
  programs.light.enable = true;
  user.extraGroups = [ "video" ];

  services.xserver.dpi = 92;

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = ["subvol=nixos"];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-label/swap"; }
    ];
}
