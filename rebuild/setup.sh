# This is a script to get my environment and computer exactly how I want it so I can reinstall Linux wherever/whenever/however many times I would like and be exactly where I need to be - At home.
# We should always update apt repos
sudo apt-get update

# Get all the goodies
xargs sudo apt-get -y install < aptpackages.txt

echo "Making the desktop pretty!"
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.theme name "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.desktop.wm.preferences theme "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.desktop.interface icon-theme "Mint-Y-Aqua"
gsettings set org.cinnamon panels-enabled "['1:0:top']"
echo "Theme set and panel moved to the top!"

# If I want brew installed + used packages
source ./brew.sh

# If I want to customize my QMK configuration
source ./qmk.sh

# Append the .bashrc file with my changes
cat bashrc_changes.sh >> ~/.bashrc
