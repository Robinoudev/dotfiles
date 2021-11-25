#!/bin/bash

set -e

function log {
	local LINE="[arch-linux-install] $*"
	echo "$LINE"
	echo "${LINE//?/-}"
}

function ask {
	read -p "$1> "
	eval "export $2=\$REPLY"
}

loadkeys dvorak
ask 'device:' DEVICE
ask 'passphrase:' __PASSPHRASE__
ask 'Which cpu ucode' __UCODE__
ask 'hostname' __HOSTNAME__
ask 'interface name' __INTERFACE__

log "Checking for internet"
ping -c 3 archlinux.org

log "Setup ntp"
timedatectl set-ntp true

log "Updating mirror list"
# reflector -c Netherlands,Germany -a 6 --sort rate --save /etc/pacman.d/mirrorlist

log "Refresh packages"
pacman -Syy

log "Installing needed packages"
pacman -Sy --needed --noconfirm cryptsetup btrfs-progs gdisk

log "clearing disk"
__TMP_MOUNT__=$(mktemp -d)
sgdisk --zap-all $DEVICE

log "partitioning the disk"
sgdisk -n1:1M:+1G -t1:EF00 $DEVICE
sgdisk -n2:0:0   $DEVICE

log "Setting up cryptmanager"
eval "export __BOOT_PART_UUID__=`blkid -s PARTUUID -o value ${DEVICE}2`"
eval "export __BOOT_MAPPER_NAME__=cryptroot-partuuid-$__BOOT_PART_UUID__"
eval "export __BOOT_MAPPER_PATH__=/dev/mapper/$__BOOT_MAPPER_NAME__"

log "Format and open LUKS container"
echo -n "${__PASSPHRASE__}" | cryptsetup luksFormat ${DEVICE}2 -
echo -n "${__PASSPHRASE__}" | cryptsetup open ${DEVICE}2 $__BOOT_MAPPER_NAME__ --key-file -

log "Format luks containers as btrfs and mount on ${__TMP_MOUNT__}"
mkfs.btrfs $__BOOT_MAPPER_PATH__ -f
mount $__BOOT_MAPPER_PATH__ $__TMP_MOUNT__

log "Create subvolumes"
cd $__TMP_MOUNT__
btrfs su cr @
mkdir @/0
btrfs su cr @/0/snapshot
for i in {home,root,srv,usr,usr/local,swap,var};
	do btrfs subvolume create @$i;
done

# exclude these dirs under /var from system snapshot
for i in {tmp,spool,log};
	do btrfs subvolume create @var/$i;
done

log "Mounting subvolumes"
cd ~
umount $__TMP_MOUNT__
mount $__BOOT_MAPPER_PATH__ $__TMP_MOUNT__ -o subvol=/@/0/snapshot,compress-force=zstd,noatime,space_cache=v2

mkdir -p $__TMP_MOUNT__/{.snapshots,home,root,srv,tmp,usr/local,swap}

mkdir -p $__TMP_MOUNT__/var/{tmp,spool,log}
mount $__BOOT_MAPPER_PATH__ $__TMP_MOUNT__/.snapshots/ -o subvol=@,compress-force=zstd,noatime,space_cache=v2

# mount subvolumes
# separate /{home,root,srv,swap,usr/local} from root filesystem
for i in {home,root,srv,swap,usr/local};
	do mount $__BOOT_MAPPER_PATH__ $__TMP_MOUNT__/$i -o subvol=@$i,compress-force=zstd,noatime,space_cache=v2;
done

# separate /var/{tmp,spool,log} from root filesystem
for i in {tmp,spool,log};
	do mount $__BOOT_MAPPER_PATH__ $__TMP_MOUNT__/var/$i -o subvol=@var/$i,compress-force=zstd,noatime,space_cache=v2;
done

log "Disable copy on write"
for i in {swap,};
	do chattr +C $__TMP_MOUNT__/$i;
done

log "Format EFI partition"
mkfs.fat -F32 -n EFI ${DEVICE}1
mkdir -p $__TMP_MOUNT__/boot
mount ${DEVICE}1 $__TMP_MOUNT__/boot

log "pacstrap essential packages"
pacstrap $__TMP_MOUNT__ base vi mandoc grub cryptsetup btrfs-progs snapper snap-pac grub grub-btrfs
chmod 750 $__TMP_MOUNT__/root
chmod 1777 $__TMP_MOUNT__/var/tmp/

log "Installing a kernel"
pacstrap $__TMP_MOUNT__ linux linux-headers linux-firmware dosfstools efibootmgr $__UCODE__

log "Generating fstab"
genfstab -U $__TMP_MOUNT__ >> $__TMP_MOUNT__/etc/fstab

log "Remove hard-coded system subvolume"
# If not removed, system will ignore btrfs default-id setting, which is used by snapper when rolling back.
sed -i 's|,subvolid=258,subvol=/@/0/snapshot,subvol=@/0/snapshot||g' $__TMP_MOUNT__/etc/fstab

log "Create LUKS key for initramfs"
# Without this, you will need to enter the password twice: once in GRUB, once in initramfs.
mkdir -p $__TMP_MOUNT__/lukskey
dd bs=512 count=8 if=/dev/urandom of=$__TMP_MOUNT__/lukskey/crypto_keyfile.bin
chmod 600 $__TMP_MOUNT__/lukskey/crypto_keyfile.bin
echo -n "${__PASSPHRASE__}" | cryptsetup luksAddKey ${DEVICE}2 $__TMP_MOUNT__/lukskey/crypto_keyfile.bin -
chmod 700 $__TMP_MOUNT__/lukskey

log "Preparing ramdisks for kernel boot"
cryptkey=/lukskey/crypto_keyfile.bin
mv $__TMP_MOUNT__/etc/mkinitcpio.conf $__TMP_MOUNT__/etc/mkinitcpio.conf.original

tee $__TMP_MOUNT__/etc/mkinitcpio.conf << EOF
BINARIES=(/usr/bin/btrfs)
FILES=($cryptkey)
HOOKS=(base udev autodetect modconf block encrypt filesystems keyboard fsck grub-btrfs-overlayfs)
EOF

log "enable cryptodisk for grub"
echo "GRUB_ENABLE_CRYPTODISK=y" >> $__TMP_MOUNT__/etc/default/grub
echo "GRUB_CMDLINE_LINUX=\"cryptdevice=PARTUUID=$__BOOT_PART_UUID__:$__BOOT_MAPPER_NAME__ root=$__BOOT_MAPPER_PATH__ cryptkey=rootfs:$cryptkey\"" >> $__TMP_MOUNT__/etc/default/grub

log "Create swap file"
touch $__TMP_MOUNT__/swap/swapfile
truncate -s 0 $__TMP_MOUNT__/swap/swapfile
chattr +C $__TMP_MOUNT__/swap/swapfile
btrfs property set $__TMP_MOUNT__/swap/swapfile compression none
dd if=/dev/zero of=$__TMP_MOUNT__/swap/swapfile bs=1M count=8192 status=progress
chmod 700 $__TMP_MOUNT__/swap
chmod 600 $__TMP_MOUNT__/swap/swapfile
mkswap $__TMP_MOUNT__/swap/swapfile
echo /swap/swapfile none swap defaults 0 0 >> $__TMP_MOUNT__/etc/fstab

log "Setting the host name"
echo $__HOSTNAME__ > $__TMP_MOUNT__/etc/hostname

log "Creating network config"
tee $__TMP_MOUNT__/etc/systemd/network/20-default.network <<EOF

[Match]
Name=$__INTERFACE__

[Network]
DHCP=yes
EOF

log "Setting the localtime"
ln -sf /usr/share/zoneinfo/Europe/Amsterdam $__TMP_MOUNT__/etc/localtime
hwclock --systohc

log "Setting the locale"
echo "en_US.UTF-8 UTF-8" >> $__TMP_MOUNT__/etc/locale.gen
echo "LANG=en_US.UTF-8" >> $__TMP_MOUNT__/etc/locale.conf

cp /etc/pacman.d/mirrorlist $__TMP_MOUNT__/etc/pacman.d/

cat << HERE > ${__TMP_MOUNT__}/arch-install-chroot.sh
set -e

function log {
  local LINE="[arch-linux-install] $*"
  echo "$LINE"
  echo "${LINE//?/-}"
}

log "Setting up database for 'pacman -F filename' searching"
pacman -Fy
echo KEYMAP=dvorak >> /etc/vconsole.conf

log "Setting up locale"
locale-gen

log "Enable networking"
pacman -S --noconfirm --needed iwd
systemctl enable iwd.service
systemctl enable systemd-networkd systemd-resolved

log "Generate initramfs"
mkinitcpio -P

log "Enable btrfs services"
systemctl enable grub-btrfs.path

log "Enable snapper"
umount /.snapshots/
rmdir /.snapshots/
snapper --no-dbus -c root create-config /
rmdir /.snapshots/
mkdir /.snapshots/
mount /.snapshots/
snapper --no-dbus -c home create-config /home/
systemctl enable /lib/systemd/system/snapper-*

log "Setting up users"
pacman -S --noconfirm sudo
echo "root:\$__PASSPHRASE__" | chpasswd
useradd -s /bin/bash -U -G wheel,video -m --btrfs-subvolume-home robin
snapper --no-dbus -c robin create-config /home/robin
echo "robin:\$__PASSPHRASE__" | chpasswd
echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel

log "Installing other dependencies"
pacman -S --noconfirm git tmux vi vim xorg-server
pacman -S --noconfirm inetutils # for hostname
pacman -S --noconfirm apcupsd # for auto-shutdown when UPS battery runs low
systemctl enable apcupsd

log "Installing gfx stuff"
pacman -S --noconfirm libva-intel-driver xf86-video-intel

log "Setting up grub"
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
grub-mkconfig -o /boot/grub/grub.cfg

exit
HERE

log "Entering chroot environment"
arch-chroot $__TMP_MOUNT__ /usr/bin/env  DISK=$DEVICE INST_UUID=$INST_UUID /bin/bash arch-install-chroot.sh

log "Finished: rebooting"
rm $__TMP_MOUNT__/arch-install-chroot.sh

mount | grep "$__TMP_MOUNT__/" | tac | cut -d' ' -f3 | xargs -i{} umount -lf {}
umount $__TMP_MOUNT__
cryptsetup close $__BOOT_MAPPER_NAME__

set +e
reboot
