# UBUNTU HACKS

I have some helpful tips that I have come accross and want to remember in [this wiki](https://github.com/jacobmoroni/ubuntu_hacks/wiki/Helpful-Ubuntu-Tips)

And I have my installation instructions from the last time I set up ubuntu 18.04 on my computer in [this one](https://github.com/jacobmoroni/ubuntu_hacks/wiki/Ubuntu-18.04-Install-Instructions)

[Ubuntu 20.04 install instructions](https://github.com/jacobmoroni/ubuntu_hacks/wiki/Ubuntu-20.04-installation)

[Ubuntu 22.04 install instructions](https://github.com/jacobmoroni/ubuntu_hacks/wiki/Ubuntu-22.04-installation)

## Files In Repo

These are the files in my repo along with some instructions on how to use them

### Shell Scripts
* resetusb.sh --resets usb drivers on computer. I use this when my computer stops detecting stuff like my keyboard
* setupvim.sh --Sets up vim how I like it. for the clipboard sharing to work, I think vim-gtk needs to be installed
* atom_files/install_atom.sh -- sets up atom the way I like it

### Terminator Files and Instructions

The next few files are to set up terminator to run like guake (located in the terminator_files folder)
* terminator config --sets up shortcuts for terminator to work how I like it. first install terminator `sudo apt install terminator` then copy the terminator folder into the .config folder in home `cp -r terminator ~/.config/` then set the default terminal back to gnome-terminal.wrapper with `sudo update-alternatives --config x-terminal-emulator` so <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>T</kbd> still opens a normal terminal. 

* terminator-daemon -- this file will auto re-launch terminator if it is ever closed so that it behaves like guake. copy it into `/usr/local/bin` and make sure it is executable

* terminator.desktop -- this needs to be placed in the `~/.config/autostart` folder so that it will run the `terminator-daemon` script on start to keep terminator always running. Now <kbd>F1</kbd> will always bring up terminator.

* [this doesnt always work so I dont use it anymore] callterm.sh --alternatively, copy this file into /usr/bin and make sure it is still executable. then set the <kbd>F1</kbd> key as the shortcut to callterm.sh. This will open an instance of terminator if there is not one already open. Or if there is one already open, it will show it (<kbd>F1</kbd> is already the hide/show key for terminator in the config file)

### Dot Files
* .aliases -- aliases for navigating faster
* .vimrc -- personal vim settings. need to firs install vundle with `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim` then run :PluginInstall to add plugins. You complete me must also be installed from source with `cd ~/.vim/bundle/YouCompleteMe` then `./install.py --clang-completer` more info from Devon's repo [here](https://github.com/DevonMorris/dotfiles,"https://github.com/DevonMorris/dotfiles") to get rid of `Disabling ros.vim: Vim with +python is required` error run `sudo apt install vim-gtk-py2` then `sudo update-alternatives --config vim` then choose the gtkpy2 option
* .tmux.conf and .tmux.conf.local --my tmux settings. I got them from [this site](https://github.com/gpakosz/.tmux "https://github.com/gpakosz/.tmux"). Another good resource for shortcuts and hotkeys for tmux can be found [here](https://gist.github.com/MohamedAlaa/2961058,"https://gist.github.com/MohamedAlaa/2961058").

* .zshrc -- shell script for zshell
* .bashrc -- my sheel script for bash back when I used it

### Other Config Files
* ipython_config.py -- copy this file into ~/.ipython/profile_default. This is for ipython with python 2.7 could be a little different with python3.5. This is to automatically import numpy and matplotlib everytime you open ipython. You can also add other ipython environment stuff here

* ROS.xml -- This sets up ros coding style with qtcreator

* dotfiles/JumpToTimeV3.lua -- VLC extension that allows jumping forwards and backwards single frames.

