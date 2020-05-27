#!/bin/bash
## [Автоустановщик Arch linux !]
#[base!]

echo "=>Разметка диска"
cfdisk /dev/sda

echo "=>Форматирование разделов !"
mkfs.ext2 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3

echo "=>Монтирование диска -> /dev/sda3 /mnt"
mount /dev/sda3 /mnt

echo "=>Создание разделов -> /mnt/boot /mnt/home /mnt/var"
mkdir /mnt/boot /mnt/home /mnt/var -v

echo "=>Монтирование раздела -> /dev/sda1 /mnt/boot"
mount /dev/sda1 /mnt/boot

echo "=>Запуск установки системы - 'pacstrap'"
pacstrap /mnt base base-devel
pacstrap /mnt grub-bios
pacstrap /mnt ifplugd  wpa_supplicant dhcpcd dialog ppp

echo "=>Запуск команды : genfstab -p /mnt >> /mnt/etc/fstab"
genfstab -p /mnt >> /mnt/etc/fstab

echo "=>Вход в arch-chroot /mnt"
arch-chroot /mnt

echo "=>Настройка часового пояса - 'default'"
hwclock --systohc --utc

echo "=>Запуск mkinitcpio"
mkinitcpio -p linux

echo "=>Создание пароля для root!"
passwd root

echo "=>Создание пользователя /home!"
useradd -mg users -G wheel -s /bin/bash programmist

echo "=>Создание пароля для programmist"
passwd programmist

echo "=>Установка загрузчика-Grub"
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo "=>Установка закончена после перезагрузки запустите chroot.sh //github.com"
reboot
