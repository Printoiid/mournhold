echo "Starting - Brew install"
# Because it's important to know who we are
username=$(whoami)
# Install Brew
yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/"$username"/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "Finished - Brew install"

echo "Starting - Brew packages install"
# Install all of the fun stuff
brew install $(cat ./brewformulae.txt)
echo "Finished - Brew packages install"
