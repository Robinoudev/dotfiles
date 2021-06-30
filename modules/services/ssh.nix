{ options, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.ssh;
in {
  options.modules.services.ssh = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      challengeResponseAuthentication = false;
      passwordAuthentication = false;
    };

    user.openssh.authorizedKeys.keys =
      if config.user.name == "robin"
      then [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC4CFZkjraGWi2A0sUZoXXMSbvSFNI1aeHFhr1iJE6KxGqvW7/RWnfSyqdHAMoLm6V07xWAdO/1xKfUfCiMpzDLH7Xdgf6b0oxNaGfBPX6uuxN4Puj4xmqTNeyjuwnfviErQshR32apyGWSO4/tFlgEIBccsxE8lR7KL668QWcCQE8Bvt1kVm6yhmkG7efK9FXjH2ECadKbFKh47XSon48tKcG0qftNpKPm1Fp+37TMEiZweLKlzjkmD4zZgd+bFAZiR1zotyil/DQxVVnXioTYXbJLust1/4rGziNifhAfAp5eq0bMRTNemx2UH/Z7IwzBp9zq6r5jOlQFnVfMkyLwqoZWCkT/nbqwAas5mU9OmxYpFz2QlcNXnG+p4qFQo6AJJBZv+IZ1bMgU4+2H+7Es991IwvvmsG+D/ALpqyemWcI+LoMHyYQZiowmtHX2jvTa+LsBjz+b9c+72pAP6wwv9kW7Jq9Kb60xa9SoAkTGfwZ7lq+owt2lA9eUXR9qI0AwKXmLVLneeZv66QiX0P/RxpJy4oz5agJI4YqCM3TxB69QqYf2zavC4ohSFt06Lxr0j54bC92jTbcIKduyhYReaNuzmzsSh1HexfFoprI9B6Opbpl2OFCnmP8r9uIU6h8/BDybsdXTTjeGb60SKoXuEMUQGcgat+zIzjRVRWjg7Q== oudevrielink@protonmail.com"
      ] else [];
  };
}
