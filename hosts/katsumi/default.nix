{ ... }:
{
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ];

  modules = {
    desktop = {
      bspwm.enable = true;
      /* plasma.enable = true; */
      apps = {
        rofi.enable = true;
      };
      term = {
        default = "alacritty";
        st.enable = true;
        alacritty.enable = true;
      };
      browsers = {
        default = "firefox";
        firefox.enable = true;
        qutebrowser.enable = true;
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
    shell = {
      bitwarden.enable = true;
      tmux.enable = true;
      zsh.enable = true;
      direnv.enable = true;
    };
    services = {
      ssh.enable = true;
      postgresql.enable = true;
      sqlite.enable = true;
    };
    theme.active = "alucard";
  };

  networking.hostName = "katsumi";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.networkmanager.enable = true;

  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
  #   enableSSHSupport = true;
  };
}
