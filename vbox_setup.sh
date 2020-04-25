#!/bin/bash

# gpt things
echo "Partitioning..."
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
mount -a

echo "Installing..."
pacstrap -i /mnt base linux linux-firmware
genfstab -U -p /mnt >> /mnt/etc/fstab
cat << EOF > /mnt/root/in_chroot.sh
passwd
pacman -Syu grub efibootmgr dosfstools os-prober mtools linux-headers linux-lts linux-lts-headers neovim dhcpcd netctl wpa_supplicant
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "en_US ISO-8859-1" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "arcticarch" >> /etc/hostname
echo "127.0.1.1 articarch.localdomain arcticarch" >> /etc/hosts

useradd -m penguin
passwd penguin

cat << EEG > /etc/netctl/start_eth_on_boot
Description='A basic dhcp ethernet connection'
Interface=enp0s3
Connection=ethernet
IP=dhcp
EEG
systemctl enable netctl-auto@enp0s3.service

pacman -Syu xorg xorg-xinit plasma-desktop sddm konsole dolphin firefox
echo "exec startkde" > ~/.xinitrc
systemctl enable sddm.service

grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
exit
EOF
chmod 777 /mnt/root/in_chroot.sh
arch-chroot /mnt /root/in_chroot.sh
echo "Install complete. Rebooting in 5 seconds..."
sleep 5
reboot
