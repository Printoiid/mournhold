echo "Starting - Kitty install"
# Pull down the installer and run it
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Create symbolic links to add kitty and kitten to PATH
# (assuming ~/.local/bin is in your system-wide PATH)
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
# Link the kitty.desktop file somewhere it can be found by the OS
ln -s ~/Mournhold/kitty/assets/kitty.desktop ~/.local/share/applications/
# Link the entire kitty directory into .config for use
ln -s ~/Mournhold/kitty/ ~/.config/
# If you want to open text files and images in kitty via your
# file manager also add the kitty-open.desktop file
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/

# Copy over sessions and settings
string=$(cat << 'EOF'
# Set up Kitty alias when launching via CLI
alias kitty='kitty --override background_image_layout=cscaled --override background_image=$(ls $HOME/.config/kitty/img/*.png | sort --random-sort | head -1)'
# Kitty sessions
alias kubelab='kitty --session sessions/kubelab.kitty-session'
EOF
)
# Add the aliases and sessions to .bashrc
cat "$string" >> ~/.bashrc

# Update the paths to the kitty and its icon in the kitty desktop file(s)
sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

# Make xdg-terminal-exec (and hence desktop environments that support it use kitty)
echo 'kitty.desktop' > ~/.config/xdg-terminals.list
echo "Finished - Kitty install"
