{ config, options, lib, ... }:

with lib;
{
  config = {
    user =
      let user = builtins.getEnv "USER";
          name = if elem user [ "" "root" ] then "robin" else user;
      in {
        inherit name;
        description = "The primary user account";
        extraGroups = [ "wheel" ];
        isNormalUser = true;
        home = "/home/${name}";
        group = "users";
        uid = 1000;
      };

    nix = let users = [ "root" config.user.name ]; in {
      trustedUsers = users;
      allowedUsers = users;
    };
  };
}
