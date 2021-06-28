{
  inputs = 
    {
      nixpkgs.url = "nixpkgs/nixos-unstable";
      nixpkgs-unstable.url = "nixpkgs/master";    # for packages on the edge
      home-manager.url = "github:rycee/home-manager/master";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";

      # Extras
      nixos-hardware.url = "github:nixos/nixos-hardware";
    };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, ...}:
    let
      inherit (lib.my) mapModules mapModulesRec mapHosts;

      system = "x86_64-linux";

      mkPkgs = pkgs:
        import pkgs {
          inherit system;
          config.allowUnfree = true;
        };
      pkgs = mkPkgs nixpkgs;

      lib = nixpkgs.lib.extend (self: super: {
        my = import ./lib {
          inherit pkgs inputs;
          lib = self;
        };
      });
    in {
      lib = lib.my;

      nixosModules =
        { dotfiles = import ./.; } // mapModulesRec ./modules import;

      nixosConfigurations =
        mapHosts ./hosts {};
      # nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     nixos-hardware.nixosModules.lenovo-thinkpad-x220
      #     ./default.nix
      #     ./hosts/thinkpad/default.nix
      #     (import ./modules)
      #   ];
      #   specialArgs = { inherit lib inputs; };
      # };

      devShell."${system}" =
        import ./shell.nix { inherit pkgs; };
    };
}
