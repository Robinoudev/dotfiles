{ config, options, lib, home-manager, ... }:

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

    home-manager = {
      home = {
        useUserPackages = true;
        # file = mkAliasDefinitions options.home.file;
        # Necessary for home-manager to work with flakes, otherwise it will
        # look for a nixpkgs channel.
        stateVersion = config.system.stateVersion;
      };
    };

    nix = let users = [ "root" config.user.name ]; in {
      trustedUsers = users;
      allowedUsers = users;
    };
  };
}
