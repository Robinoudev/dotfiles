{ config, lib, pkgs, ... }:

with lib;
let
  customKeyboardLayout = pkgs.writeText "custom-keyboard-layout" ''
    xkb_keymap {
      xkb_keycodes { include "evdev+aliases(qwerty)" };
      xkb_types    { include "complete" };
      xkb_compat   { include "complete" };
      partial alphanumeric_keys
      xkb_symbols "real-prog-dvorak" {
       include "pc+us(dvorak)+inet(evdev)+capslock(swapescape)"

        key <TLDE> { [       dollar,        asciitilde, dead_grave, dead_tilde      ] };

        key <AE01> { [          plus,       1               ]       };
        key <AE02> { [          bracketleft,        2               ]       };
        key <AE03> { [          braceleft,  3       ]       };
        key <AE04> { [          parenleft,  4               ]       };
        key <AE05> { [          ampersand,      5               ]       };
        key <AE06> { [          equal,  6, dead_circumflex, dead_circumflex ]   };
        key <AE07> { [          parenright, 7       ]       };
        key <AE08> { [          braceright, 8       ]       };
        key <AE09> { [          bracketright,       9,  dead_grave] };
        key <AE10> { [          asterisk,   0       ]       };
        key <AE11> { [ exclam,      percent ]       };
        key <AE12> { [ bar, grave,  dead_tilde] };

        key <AD01> { [  semicolon,  colon, dead_acute, dead_diaeresis       ] };
        key <AD02> { [      comma,  less,   dead_cedilla, dead_caron        ] };
        key <AD03> { [      period, greater, dead_abovedot, periodcentered  ] };
        key <AD04> { [          p,  P               ]       };
        key <AD05> { [          y,  Y               ]       };
        key <AD06> { [          f,  F               ]       };
        key <AD07> { [          g,  G               ]       };
        key <AD08> { [          c,  C               ]       };
        key <AD09> { [          r,  R               ]       };
        key <AD10> { [          l,  L               ]       };
        key <AD11> { [      slash,  question        ]       };
        key <AD12> { [      at,     asciicircum             ]       };

        key <AC01> { [          a,  A               ]       };
        key <AC02> { [          o,  O               ]       };
        key <AC03> { [          e,  E               ]       };
        key <AC04> { [          u,  U               ]       };
        key <AC05> { [          i,  I               ]       };
        key <AC06> { [          d,  D               ]       };
        key <AC07> { [          h,  H               ]       };
        key <AC08> { [          t,  T               ]       };
        key <AC09> { [          n,  N               ]       };
        key <AC10> { [          s,  S               ]       };
        key <AC11> { [      minus,  underscore      ]       };

        key <AB01> { [   apostrophe,        quotedbl, dead_ogonek, dead_doubleacute ] };
        key <AB02> { [          q,  Q               ]       };
        key <AB03> { [          j,  J               ]       };
        key <AB04> { [          k,  K               ]       };
        key <AB05> { [          x,  X               ]       };
        key <AB06> { [          b,  B               ]       };
        key <AB07> { [          m,  M               ]       };
        key <AB08> { [          w,  W               ]       };
        key <AB09> { [          v,  V               ]       };
        key <AB10> { [          z,  Z               ]       };

        key <BKSL> { [  backslash,  numbersign             ]       };
      };
      xkb_geometry { include "pc(pc104)" };
    };
  '';
  compiledKeyboardLayout = pkgs.runCommand "compiled-keyboard-layout" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customKeyboardLayout} $out
  '';
in {
  time.timeZone = mkDefault "Europe/Amsterdam";
  location = {
    latitude = 52.46083;
    longitude = 6.56528;
  };

  # Bitwarden server
  modules.shell.bitwarden.config.server = "vault.oudevrielink.net";

  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = [ pkgs.xorg.xkbcomp ];
  services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customKeyboardLayout} $DISPLAY";
  services.xserver.autoRepeatDelay = 250;
  services.xserver.autoRepeatInterval = 50;

  # Configure the console keymap from the xserver keyboard settings
  console.useXkbConfig = true;

  networking.hosts =
    let hostConfig = {
          "192.168.1.141" = [ "thinkpad" ];
        };
        hosts = flatten (attrValues hostConfig);
        hostName = config.networking.hostName;
      in mkIf (builtins.elem hostName hosts) hostConfig;
}
