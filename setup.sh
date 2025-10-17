# This is a script to get my environment and computer exactly how I want it so I can reinstall Linux wherever/whenever/however many times I would like and be exactly where I need to be - At home.
# We should always update apt repos
sudo apt-get update

# Get all the goodies
xargs sudo apt-get -y install < ./rebuild/aptpackages.txt

# Desktop configuration
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.theme name "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.desktop.wm.preferences theme "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.desktop.interface icon-theme "Mint-Y-Aqua"
gsettings set org.cinnamon panels-enabled "['1:0:top']"

# Fonts - Setup
ln -s ~/Mournhold/fonts/* ~/.local/share/fonts

# OhMyPosh - Setup
source ~/Mournhold/ohmyposh/ohmyposh-setup.sh

# Kitty - Setup
source ~/Mournhold/kitty/kitty-setup.sh

# Links
ln -s ~/Mournhold/kitty/ ~/.config/
