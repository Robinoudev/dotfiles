{ config, lib, ... }:

with lib.my;
{

  imports = [
    ../home.nix
    ../server.nix
    ./hardware-configuration.nix   

    ./modules/vaultwarden.nix
    ./modules/gitea.nix
  ];

  modules = {
    shell = {
      direnv.enable = true;
      git.enable = true;
      zsh.enable = true;
      gnupg.enable = true;
    };
    services = {
      fail2ban.enable = true;
      ssh.enable = true;
      nginx.enable = true;
    };

    theme.active = "alucard";
  };

  ## Local config
  networking.networkmanager.enable = true;

  # nginx hosts
  services.nginx.virtualHosts."oudevrielink.net" = {
    default = true;
    forceSSL = true;
    enableACME = true;
    locations = {
      "~* \.(?:ico|css|map|js|gif|jpe?g|png|ttf|woff|html)$".extraConfig = ''
        access_log off;
        expires 30d;
        add_header Pragma public;
        add_header Cache-Control "public, mustrevalidate, proxy-revalidate";
      '';
      "/".extraConfig = ''
        client_max_body_size 10m;
      '';
    };
  };

  security.acme.email = "robin@oudevrielink.net";
}
