#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# Update packages list and update system
apt update
apt upgrade -y

cd $builddir
cd WhiteSur-gtk-theme
./install.sh --nord || exit

cd $builddir
cd WhiteSur-gtk-theme
./tweaks.sh -f monterey || exit

cd $builddir
cd Nordzy-icon
./install.sh --total || exit

cd $builddir
cd Nordzy-cursors
./install.sh || exit

cd $builddir
git clone https://github.com/arcticicestudio/nord-gnome-terminal.git
cd nord-gnome-terminal/src
./nord.sh || exit

cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.config/autostart
mkdir -p /home/$username/.local/share/fonts
mkdir -p /home/$username/.local/share/wallpapers
mkdir -p /home/$username/.local/share/plank/themes
mkdir -p /home/$username/.config/ulauncher/user-themes/

# Installing fonts
cd $builddir 
apt install fonts-font-awesome -y

unzip fonts.zip -do /home/$username/.local/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -do /home/$username/.local/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -do /home/$username/.local/share/fonts

unzip wallpapers.zip -do /home/$username/.local/share/wallpapers

# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

dconf load /org/cinnamon/ < cinnamon-nord.conf

#install conky
apt install plank -y
unzip plank-theme.zip -do /home/$username/.local/share/plank/themes


#Install ulaucher.io
cd $builddir 
cd packages
apt install ./ulauncher_5.15.1_all.deb -y
cd $builddir
unzip ulauncher-theme.zip -do /home/$username/.config/ulauncher/user-themes/

#install conky
cd $builddir 
apt install conky-all jq curl moc -y
unzip conky-config.zip -do /home/$username/.config
​cp conky-startup.desktop /home/$username/.config/autostart


apt install nautilus nautilus-admin nautilus-extension-gnome-terminal

echo MUFFIN_NO_SHADOWS=1 >> /etc/environment


chown -R $username:$username /home/$username
