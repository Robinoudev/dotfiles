{ config, options, lib, ... }:

with lib;
with lib.my;

{
  options = with types; {
    user = mkOpt attrs { };

    dotfiles = let t = either str path; in {
      dir = mkOpt t
        (findFirst pathExists (toString ../.) [
          "${config.user.home}/.config/dotfiles"
          "/etc/dotfiles"
        ]);
      binDir     = mkOpt t "${config.dotfiles.dir}/bin";
      configDir  = mkOpt t "${config.dotfiles.dir}/config";
      modulesDir = mkOpt t "${config.dotfiles.dir}/modules";
      themesDir  = mkOpt t "${config.dotfiles.modulesDir}/themes";
    };

    home = {
      file       = mkOpt' attrs {} "Files to place directly in $HOME";
      configFile = mkOpt' attrs {} "Files to place in $XDG_CONFIG_HOME";
      dataFile   = mkOpt' attrs {} "Files to place in $XDG_DATA_HOME";
    };
  };


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
      useUserPackages = true;

      users.${config.user.name} = {
        home = {
          file = mkAliasDefinitions options.home.file;
          # Necessary for home-manager to work with flakes, otherwise it will
          # look for a nixpkgs channel.
          stateVersion = config.system.stateVersion;
        };
      };
    };

    users.users.${config.user.name} = mkAliasDefinitions options.user;

    nix = let users = [ "root" config.user.name ]; in {
      trustedUsers = users;
      allowedUsers = users;
    };
  };
}
