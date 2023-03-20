pacman -Syu --noconfirm --needed

read -r -p "
------------------------------------------------------------------------------------

Are you recieving the error 'unable to lock database' [Y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        rm /var/lib/pacman/db.lck
        ;;
    *)
        
        ;;
esac
read -r -p "
Are you recieving the error 'failed to synchronize all databases' [Y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        rm -rf /var/lib/pacman/sync/ && pacman -Sy
        ;;
    *)
        
        ;;
esac
read -r -p "
Are you recieving the error 'unable to lock database' for Pamac? [Y/N] " response
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
        pacman -Syyu && update-grub
        ;;
    *)
        
        ;;
esac
read -r -p "
After an update can you not login to your desktop enviroment? [NVIDIA] [Y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        pacman -R nvidia-dkms && pacman -S nvidia-dkms && update-grub
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
