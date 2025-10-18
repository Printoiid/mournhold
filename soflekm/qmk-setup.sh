# For QMK configuration
echo "Starting - QMK install"
python3 -m pip install --user qmk --break-system-packages

ln -s ~/Mournhold/soflekm/Lizardbutt/ ~/qmk_firmware/keyboards/sofle_choc/keymaps/
echo "Finished - QMK install"
