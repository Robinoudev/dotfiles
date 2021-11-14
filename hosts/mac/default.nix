{ config, lib, ... }:

with lib.my;
{

  imports = [
    ../server.nix
  ];

  modules = {
    shell = {
      direnv.enable = true;
      git.enable = true;
      zsh.enable = true;
    };
    services = {
      ssh.enable = true;
      nginx.enable = true;
    };
  };

  ## Local config
  networking.networkmanager.enable = true;

  # nginx hosts
  services.nginx.virtualHosts."v0.io" = {
    default = true;
    forceSSL = true;
    enableACME = true;
    locations = {
      "~* \.(?:ico|css|map|js|gif|jpe?g|png|ttf|woff)$".extraConfig = ''
        access_log off;
        expires 30d;
        add_header Pragma public;
        add_header Cache-Control "public, mustrevalidate, proxy-revalidate";
        proxy_pass http://kiiro:8000;
        proxy_buffering off;
      '';
      "/".extraConfig = ''
        client_max_body_size 10m;
        proxy_pass http://kiiro:8000;
        proxy_buffering off;
        proxy_redirect off;
      '';
    };
  };

  security.acme.email = "robin@oudevrielink.net";
}
