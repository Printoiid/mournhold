# This is a script to get my environment and computer exactly how I want it so I can reinstall Linux wherever/whenever/however many times I would like and be exactly where I need to be - At home.

# Because it's important to know who we are
username=$(whoami)

# We should always update apt repos
sudo apt update

# Change to Downloads for Deb package downloads
cd ~/Downloads

# Get Steam and Nvidia drivers installed (The basics of course)
yes | sudo apt-get install steam nvidia-driver-575 git tree spotify-client keepassxc

# Download Discord and Vivaldi deb packages
wget "https://downloads.vivaldi.com/stable/vivaldi-stable_7.5.3735.66-1_amd64.deb"
wget "https://discord.com/api/download?platform=linux&format=deb"

# Install Discord and Vivaldi
sudo dpkg -i "vivaldi-stable_7.5.3735.66-1_amd64.deb"
sudo dpkg -i "download?platform=linux&format=deb"

# Make the desktop pretty
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.theme name "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.desktop.wm.preferences theme "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.desktop.interface icon-theme "Mint-Y-Aqua"

# Install Brew
yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> /home/"$username"/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/"$username"/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
sudo apt-get install build-essential
brew install gcc

# Install Neovim and configure the local repo
brew install neovim

# Set up my Neovim configuration from Git
cd ../Documents
git clone https://github.com/Printoiid/Mournhold.git
ln -s ~/Documents/Mournhold/nvim ~/.config/nvim

