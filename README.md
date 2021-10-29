[![NixOS 21.05](https://img.shields.io/badge/NixOS-v21.05-blue.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)

These dotfiles are heavily inspred by [hlissner/dotfiles](https://github.com/hlissner/dotfiles)

Some reminders on how te create a btrfs system

```bash
mkfs.vfat -n BOOT /dev/sda1
mkfs.btrfs -L root /dev/sda2

mount -t btrfs /dev/sda2 /mnt/
btrfs subvolume create /mnt/nixos
umount /mnt/
mount -t btrfs -o subvol=nixos /dev/sda2 /mnt/
btrfs subvolume create /mnt/var
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/tmp

mkdir /mnt/boot
mount /dev/sda1 /mnt/boot/

nixos-generate-config --root /mnt/

# edit the config; see
# https://nixos.org/nixos/manual/index.html#sec-installation
vim /mnt/etc/nixos/configuration.nix
nixos-install
reboot
```
