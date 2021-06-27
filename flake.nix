{
  inputs = 
    {
      nixpkgs.url = "nixpkgs/nixos-unstable";
      nixpkgs-unstable.url = "nixpkgs/master";    # for packages on the edge

      # Extras
      nixos-hardware.url = "github:nixos/nixos-hardware";
    };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, nixos-hardware, ...}:
    {
      nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-x220
        ];
      };
    };
}
