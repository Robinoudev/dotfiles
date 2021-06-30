{
  inputs = 
    {
      nixpkgs.url = "nixpkgs/nixos-unstable";
      nixpkgs-unstable.url = "nixpkgs/master";    # for packages on the edge
      home-manager.url = "github:rycee/home-manager/master";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";

      # Extras
      nixos-hardware.url = "github:nixos/nixos-hardware";
      emacs-overlay.url = "github:nix-community/emacs-overlay";
    };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, ...}:
    let
      inherit (lib.my) mapModules mapModulesRec mapHosts;

      system = "x86_64-linux";

      mkPkgs = pkgs: extraOverlays: import pkgs {
        inherit system;
        config.allowUnfree = true;  # forgive me Stallman senpai
        overlays = extraOverlays ++ (lib.attrValues self.overlays);
      };
      pkgs  = mkPkgs nixpkgs [ self.overlay ];
      pkgs' = mkPkgs nixpkgs-unstable [];

      lib = nixpkgs.lib.extend (self: super: {
        my = import ./lib {
          inherit pkgs inputs;
          lib = self;
        };
      });
    in {
      lib = lib.my;

      overlay =
        final: prev: {
          unstable = pkgs';
          my = self.packages."${system}";
        };

      overlays =
        mapModules ./overlays import;

      nixosModules =
        { dotfiles = import ./.; } // mapModulesRec ./modules import;

      nixosConfigurations =
        mapHosts ./hosts {};

      devShell."${system}" =
        import ./shell.nix { inherit pkgs; };

      defaultApp."${system}" = {
        type = "app";
        program = ./bin/hey;
      };
    };
}
