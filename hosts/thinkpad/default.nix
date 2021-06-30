{ ... }:
{
  imports = [./hardware-configuration.nix];

  modules = {
    desktop = {
      bspwm.enable = true;
      apps = {
        rofi.enable = true;
      };
      term = {
        default = "xst";
        st.enable = true;
      };
      browsers = {
        default = "firefox";
        firefox.enable = true;
        # qutebrowser.enable = true;
      };
    };
    editors = {
      emacs.enable = true;
    };
    shell = {
      tmux.enable = true;
      zsh.enable = true;
    };
    dev = {
      node.enable = true;
      elixir.enable = true;
    };
    services = {
      ssh.enable = true;
    };
    theme.active = "alucard";
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";
  location = {
    latitude = 52.46083;
    longitude = 6.56528;
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dvorak";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    autoRepeatDelay = 250;
    autoRepeatInterval = 50;
    layout = "us";
    xkbVariant = "dvorak";
    xkbOptions = "caps:swapescape";
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
  #   enableSSHSupport = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
