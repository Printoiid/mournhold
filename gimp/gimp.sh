cd ~/Documents/
if [ ! -d "~/Documents/PhotoGIMP/" ]; then
	echo "Wow! The path ~/Documents/PhotoGIMP/ already exists!"
	git clone https://github.com/Diolinux/PhotoGIMP.git
fi 
echo "Time to move some files!"
cp -R -f ~/Documents/PhotoGIMP/.config/GIMP ~/.config/
cp -R -f ~/Documents/PhotoGIMP/.local/share ~/.local/
echo "GIMP setup is done! removing .git repo files"
sudo rm -r ~/Documents/PhotoGIMP
echo "Repository cleaned!"
