let key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKd60bhYr1BDSTCiE6avGbQhnO6vPAH/bqCIbOGv+Efy robin@oudevrielink.net";
in {
  "vaultwarden-smtp-env.age".publicKeys = [key];
}
