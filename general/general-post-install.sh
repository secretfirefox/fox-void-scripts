# This script was made by Secret Firefox.
# This speeds up post installation on your Void Linux.
# This version is for the user to install their own DE/WM later.
# Enjoy! (Mandatory)

#                                                          #
# [Steps bellow are for post-installation and basic setup] #
#                                                          #

# Update the system

sudo xbps-install -Syu

# Add the nonfree repository

sudo xbps-install -Rs void-repo-nonfree -y

# Install dbus, elogind and NetworkManager

sudo xbps-install dbus elogind NetworkManager -y

# Install recommended packages

sudo xbps-install curl wget git xz unzip zip nano vim gptfdisk xtools mtools mlocate ntfs-3g fuse-exfat bash-completion linux-headers ffmpeg mesa-vdpau mesa-vaapi htop fastfetch psmisc 7zip cpupower xmirror mesa-demos noto-fonts-cjk noto-fonts-emoji xdg-user-dirs xdg-user-dirs-gtk -y

# Install development packages

sudo xbps-install autoconf automake bison m4 make libtool flex meson ninja optipng sassc -y

# Install sound system (Pipewire and Wireplumber)

sudo xbps-install pipewire wireplumber -y

# Authorize and set Pipewire and Wireplumber to autostart

sudo chmod +x /usr/share/applications/pipewire.desktop
sudo chmod +x /usr/share/applications/pipewire-pulse.desktop
sudo chmod +x /usr/share/applications/wireplumber.desktop
sudo ln -s /usr/share/applications/pipewire.desktop /etc/xdg/autostart
sudo ln -s /usr/share/applications/pipewire-pulse.desktop /etc/xdg/autostart
sudo ln -s /usr/share/applications/wireplumber.desktop /etc/xdg/autostart

# Install cronie and enable its service 

sudo xbps-install cronie -y
sudo ln -s /etc/sv/cronie /var/service

# Install a logging daemon

sudo xbps-install socklog-void -y
sudo ln -s /etc/sv/socklog-unix /var/service
sudo ln -s /etc/sv/nanoklogd /var/service

# Install Profile Sync Daemon (speeds up browsers)

git clone https://github.com/madand/runit-services
cd runit-services
sudo mv psd /etc/sv/
sudo ln -s /etc/sv/psd /var/service/
sudo chmod +x /etc/sv/psd/*
cd ..
sudo rm -rf runit-services

# Install Firefox and set a better font for it

sudo xbps-install firefox firefox-i18n-en-US -y
sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
sudo xbps-reconfigure -f fontconfig

# Run some xdg-utilities to make GTK apps appear more ready

xdg-user-dirs-update
xdg-user-dirs-gtk-update

# Switch off dhcpcd and wpa_supplicant in favor of Network Manager 

#sudo sv down dhcpcd wpa_supplicant
#sudo touch /etc/sv/dhcpcd/down /etc/sv/wpa_supplicant/down
#sudo sv status dhcpcd
#sudo sv status wpa_supplicant

# Enable dbus, elogind and NetworkManager

#sudo ln -s /etc/sv/dbus /var/service
#sudo ln -s /etc/sv/elogind /var/service
#sudo ln -s /etc/sv/NetworkManager /var/service

# Inform finished installation

echo "Installation complete. Please reboot your computer." 


