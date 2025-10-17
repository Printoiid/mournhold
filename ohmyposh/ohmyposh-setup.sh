# Set up basic OMP with preset theme
string=$(cat << 'EOF'
# Oh My Posh startup-files
eval "$(oh-my-posh init bash --config "agnoster.minimal")"
EOF
)
echo "$string" >> ~/.bashrc
