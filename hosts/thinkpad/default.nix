{ ... }:
{
  imports = [
    <nixos-hardware/lenovo/thinkpad/x220>
    ../home.nix
    ./hardware-configuration.nix
  ];
}
