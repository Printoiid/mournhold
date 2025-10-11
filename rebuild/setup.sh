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

echo "Setting up custom keymaps"
custombindpath="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['${custombindpath}flameshot-screenshot/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-screenshot/ binding "<Ctrl><Shift>3"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot-screenshot/ command "flameshot gui --accept-on-select --clipboard --path ~/Pictures/$(date '+%a-%M:%H-%h-%d-%Y')"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "flameshot-screenshot"

# If I want brew installed + used packages
# source ./brew.sh

# If I want to customize my QMK configuration
# source ./qmk.sh
