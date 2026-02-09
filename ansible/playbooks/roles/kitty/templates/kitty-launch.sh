# This is the file we want to use to launch kitty each and every time.
kitty --override background_image_layout=cscaled --override background_image=$(ls ~/.config/kitty/img/*.png | sort --random-sort | head -1)
