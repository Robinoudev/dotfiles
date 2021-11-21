{ ... }:
{
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ];

  modules = {
    desktop = {
      bspwm.enable = true;
      # plasma.enable = true;
      # xfce.enable = true;
      apps = {
        rofi.enable = true;
        zathura.enable = true;
      };
      term = {
        default = "alacritty";
        st.enable = true;
        alacritty.enable = true;
      };
      browsers = {
        default = "brave";
        firefox.enable = true;
        brave.enable = true;
        chromium.enable = true;
        # qutebrowser.enable = true;
      };
    };
    editors = {
      default = "nvim";
      emacs.enable = true;
      vim.enable = true;
    };
    dev = {
      node.enable = true;
      elixir.enable = true;
      rust.enable = true;
    };
    hardware = {
      audio.enable = true;
    };
    shell = {
      vaultwarden.enable = true;
      tmux.enable = true;
      zsh.enable = true;
      direnv.enable = true;
      git.enable = true;
      gnupg.enable = true;
    };
    services = {
      ssh.enable = true;
      postgresql.enable = true;
      sqlite.enable = true;
      bluetooth.enable = true;
    };
    theme.active = "alucard";
  };

  networking.hostName = "thinkpad";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.networkmanager.enable = true;

  environment.variables.XCURSOR_SIZE = "16";

  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
  #   enableSSHSupport = true;
  };
}
