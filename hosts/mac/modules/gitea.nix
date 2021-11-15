{ config, lib, ... }:

{
  modules.services.gitea.enable = true;

  services.gitea = {
    appName = "GITEA";
    domain = "oudevrielink.net";
    rootUrl = "https://git.oudevrielink.net/";
    disableRegistration = true;
    settings = {
      server.SSH_DOMAIN = "oudevrielink.net";
      mailer = {
        ENABLED = true;
        FROM = "git@oudevrielink.net";
        HOST = "smtp.fastmail.com:587";
        USER = "robin@oudevrielink.net";
        MAILER_TYPE = "smtp";
      };
    };
    mailerPasswordFile = config.age.secrets.gitea-smtp-env.path;
  };

  services.nginx.virtualHosts."git.oudevrielink.net" = {
    forceSSL = true;
    enableACME = true;
    root = "/srv/www/git.oudevrielink.net";
    locations."/".proxyPass = "http://127.0.0.1:3000";
  };
}
