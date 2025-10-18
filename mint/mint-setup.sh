# Desktop configuration
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.theme name "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.desktop.wm.preferences theme "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.desktop.interface icon-theme "Mint-Y-Aqua"
gsettings set org.cinnamon panels-enabled "['1:0:top']"

# Fonts - Setup
ln -s ~/Mournhold/fonts/* ~/.local/share/fonts

# We should always update apt repos
sudo apt-get update

# Get all the goodies
xargs sudo apt-get -y install < aptpackages.txt
