{ config, lib, pkgs, ... }:

{
  services.vaultwarden.backupDir = "/backups/vaultwarden";
  services.gitea.dump.enable = true;
  services.gitea.dump.backupDir = "/backups/gitea";
  system.activationScripts.createBackupDir = ''
    mkdir -m 750 -p "${config.services.vaultwarden.backupDir}" || true
    mkdir -m 750 -p "${config.services.gitea.dump.backupDir}" || true
    chown vaultwarden:vaultwarden "${config.services.vaultwarden.backupDir}"
    chown git:gitea "${config.services.gitea.dump.backupDir}"
  '';
}
