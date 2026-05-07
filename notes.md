## To-do

### Ansible

- Add in QMK steps: (Completed May 6th 2026)
    1. Run `qmk setup Printoiid/qmk_firmare` against `git@github.com/printoiid/qmk_firmare.git`
    1. Update connection type from https to ssh (Because we need to be able to push changes too):
        - `cd ~/qmk_firmware`
        - `git remote set-url origin git@github.com:Printoiid/qmk_firmware.git`
    1. Update my fork with:
        - `git fetch upstream`
        - `git rebase upstream/master`
        - `git push origin`
    1. Set up symbolic links
        - `ln -s ~/qmk_firmware/keyboards/ ~/mournhold/qmk_keymaps`
