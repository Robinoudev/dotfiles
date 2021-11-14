{ config, lib, ... }:

{
  modules.services.vaultwarden.enable = true;

  services.vaultwarden.config = {
    signupsAllowed = false;
    invitationsAllowed = true;
    domain = "https://v.oudevrielink.net";
    httpPort = 8002;
  };

  # Inject secrets at runtime
  systemd.services.vaultwarden.serviceConfig = {
    EnvironmentFile = [ config.age.secrets.vaultwarden-smtp-env.path ];
    Restart = "on-failure";
    RestartSec = "2s";
  };

  services.nginx.virtualHosts."v.oudevrielink.net" = {
    forceSSL = true;
    enableACME = true;
    root = "/srv/www/v.oudevrielink.net";
    extraConfig = ''
      client_max_body_size 128M;
    '';
    locations = {
      "/".proxyPass = "http://127.0.0.1:8000";
      "/notifications/hub".proxyWebsockets = true;
      "/notifications/hub/negotiate".proxyPass = "http://127.0.0.1:8001";
    };
  };
}
