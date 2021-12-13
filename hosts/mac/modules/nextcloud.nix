{ config, lib, ... }:

{
  services.nextcloud = {
      enable = true;
      hostName = "c.oudevrielink.net";
      https = true;
      autoUpdateApps.enable = true;
      autoUpdateApps.startAt = "05:00:00";
      config = {
        overwriteProtocol = "https";
        dbtype = "pgsql";
        dbuser = "nextcloud";
        dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
        dbname = "nextcloud";
        dbpassFile = "/var/nextcloud-db-pass";
        adminpassFile = "/var/nextcloud-admin-pass";
        adminuser = "admin";
    };
  };

  services.postgresql = {
    enable = true;

    # Ensure the database, user, and permissions always exist
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      {
        name = "nextcloud";
        ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
      }
    ];
  };

  services.nginx.virtualHosts."c.oudevrielink.net" = {
    forceSSL = true;
    enableACME = true;
  };

  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };
}
