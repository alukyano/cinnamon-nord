git clone https://github.com/vinceliuce/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme
./install.sh --nord

git clone https://github.com/alvatip/Nordzy-icon.git
cd Nordzy-icon
./install.sh --total


git clone https://github.com/alvatip/Nordzy-cursors.git
cd Nordzy-cursors
./install.sh


#-- fonts.zip --> .local/share/fonts
#-- wallpapers.zip --> .local/share/wallpapers

#dconf load /org/cinnamon/ < cinnamon-nord.conf


sudo apt-get install plank


#-- plnak-theme.zip --> .local/share/plank/themes
#set plank theme
#add plank to startup with delay 5 sec


#Install ulaucher.io

sudo apt-get install conky-all jq curl moc
#-- conky-config.zip --> .config/conky

#add to /etc/environment  MUFFIN_NO_SHADOWS=1