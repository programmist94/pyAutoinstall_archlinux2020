#!/bin/bash
echo "Настройка имени ПК"
hostnamectl set-hostname programmist

echo "Настройка подключения к интернету !"
ip link
systemctl start dhcpcd.service
sudo pacman -Syyuu
sudo pacman -S ifplugd wpa_supplicant dhcpcd dialog ppp
exit
