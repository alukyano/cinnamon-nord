
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
./install.sh --nord
./tweak.sh -f monterey

cd $builddir
cd /Nordzy-icon
./install.sh --total

cd $builddir
cd Nordzy-cursors
./install.sh


git clone https://github.com/arcticicestudio/nord-gnome-terminal.git
cd nord-gnome-terminal/src
./nord.sh

cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.config/autostart
mkdir -p /home/$username/.local/share/fonts
mkdir -p /home/$username/.local/share/wallpapers
mkdir -p /home/$username/.local/share/plank/themes

# Installing fonts
cd $builddir 
apt-get install fonts-font-awesome -y

unzip fonts.zip -d /home/$username/.local/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.local/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /home/$username/.local/share/fonts

unzip wallpapers.zip -d /home/$username/.local/share/wallpapers

# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

dconf load /org/cinnamon/ < cinnamon-nord.conf

#install conky
apt-get install plank -y
unzip plank-theme.zip -d /home/$username/.local/share/plank/themes


#Install ulaucher.io

#install conky
apt-get install conky-all jq curl moc -y
unzip conky-config.zip -d /home/$username/.config
​cp conky-startup.desktop to /home/$username/.config/autostart


apt-get install nautilus nautilus-admin nautilus-extension-gnome-terminal

echo MUFFIN_NO_SHADOWS=1 >> /etc/environment


chown -R $username:$username /home/$username
