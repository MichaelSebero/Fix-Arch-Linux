#!/usr/bin/env bash

pacman -Syu --noconfirm --needed

read -r -p "
------------------------------------------------------------------------------------

Are you receiving the error 'Unable to lock database' [Y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        rm /var/lib/pacman/db.lck
        ;;
    *)
        
        ;;
esac
read -r -p "
Are you receiving the error 'Failed to synchronize all databases' [Y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        rm -rf /var/lib/pacman/sync/ && pacman -Sy
        ;;
    *)
        
        ;;
esac
read -r -p "
Are you receiving the error 'Unable to lock database' for Pamac? [Y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        rm /var/tmp/pamac/dbs/db.lck
        ;;
    *)
        
        ;;
esac
read -r -p "
Are you having GPG key errors? [Y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        mv /etc/pacman.d/gnupg{,.bak} && pacman-key --init && pacman-key --populate archlinux && pacman-key --populate artix && pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com && pacman-key --lsign-key FBA220DFC880C036 && pacman -U --noconfirm --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
        ;;
    *)
        
        ;;
esac
read -r -p "
After an update can you not login to your desktop enviroment? [Y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
    	if $(command -v update-grub); then
        	update-grub
        fi
        ;;
    *)
        
        ;;
esac
read -r -p "
After an update can you not login to your desktop enviroment? [NVIDIA] [Y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
		if [ $(pacman -Qs nvidia-dkms) ]; then
        	pacman -R nvidia-dkms && pacman -S nvidia-dkms
        fi
    	if $(command -v update-grub); then
        	update-grub
        fi
        ;;
    *)
        
        ;;
esac
read -r -p "
Are most packages corrupted on the system? [Y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        pacman -Syu --overwrite "*" $(pacman  -Qnq)
        ;;
    *)
        
        ;;
esac
