#!/bin/bash

# gpt things
parted /dev/sda mklabel gpt
mount -a
parted --align minimal /dev/sda mkpart primary 0% 1MiB
parted /dev/sda set 1 bios_grub on
parted --align minimal /dev/sda mkpart primary 1MiB 25GiB
parted --align minimal /dev/sda mkpart primary 25GiB 100%
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3
mount /dev/sda2 /mnt
mkdir /mnt/home
mount /dev/sda3 /mnt/home

pacstrap -i /mnt base
genfstab -U -p /mnt >> /mnt/etc/fstab
passwd
pacman -S grub efibootmgr dosfstools os-prober mtools linux-headers linux-lts linux-lts-headers neovim
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
nvim /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "arcticarch" >> /etc/hostname
echo "127.0.1.1 articarch.localdomain arcticarch" >> /etc/hosts
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
exit
reboot
