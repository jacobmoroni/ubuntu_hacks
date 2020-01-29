# Ubuntu 18.04 Install Notes
***
This is the way I set up my ubuntu 18.04 Install last time I did it. In this order
***
## BIOS Setup
 Do this before installing ubuntu. Or at least before anything else
* disable secure boot in BIOS
* also in bios it may be necessary to disable hybrid graphics. I currently have hybrid graphics disabled too, but I think with nvidia-prime you can leave this on
and actually switch between the nvidia gpu and the integrated intel gpu(much better battery life)
***

## Update and Upgrade everything
Do this befor you start trying to figure anything else out becasue a lot of things wont be set up right yet
```shell
sudo apt update
```
```
sudo apt upgrade
```
```
sudo reboot now
```
***

## Set up NVIDIA Drivers
* you can do this from command line by adding a repo and then apt installing the drivers from there. 

* But it is a little more fool-proof to just go to 
 <kbd>Software & Updates</kbd> then click <kbd>additional-drivers</kbd> and select the newest nvidia one then wait for it to finish then reboot again. 

* you can verify it is working by going to <kbd>settings->details</kbd> and the nvidia GPU should be listed instead of the integrated one. 
also running `nvidia-smi` will show gpu usage (this will only work after it is set up)
* `nvidia-settings` opens a display menu to customize settings

 ### Optionally, install cuda now
 using [NVIDIA's installation guide](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html) walks you through this pretty well. But I will include some helpful tips that I used

* this was helpful when trying to install cuda stuff (it broke apt and this recovered it)
```shell
sudo apt-get -o Dpkg::Options::="--force-overwrite" install --fix-broken
```

* also if you get to making the sample cuda stuff and you get an error that says something about "missing nvscibuf.h" there is actually a missing file or something in cuda 10.2 so on the nvidia forum they said they are researching, but for now to just use `make -k` (to keep going after the error and build the other stuff)
***

## Install Chrome
```shell
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
```
```
sudo dpkg -i google-chrome-stable_current_amd64.deb
```
***

## Install Some Helpful Packages
```shell
sudo apt install htop vim vim-gtk curl git ssh
```
***

## Set up SSH stuff
* this will create a public ssh key at `~/.ssh/id_rsa.pub`
```
ssh-keygen -t rsa -b 4096 -C "email@example.com"
```
* add the ssh keys at gitlab/github click on profile then settings then ssh-keys then add ssh key and copy it into there
***

## Install ROS and other dependencies
This is good to do next because it will install a lot of other dependencies that you will need

* best to do it with the update_dependencies script because that handles ros and all of the other dependencies that we need here. it is in [anansi_dev_tools/flight_computer_setup](https://gitlab.com/fortem/anansi_dev_tools) just clone this repo.
* before you run the script, make sure that the folder that you have installed it into is in the `possible_code_dirs` arguement on line 14
  * for exmaple: I install this is a directory called workspaces in my home directory so I add this on to the end `"${USER_HOME}/workspaces"`
* then run the script `./update_dependencies.sh`

This will install ROS and python and pip install a lot of python packages as well
***
## Gnome Extensions
I like to use a few gnome extensions. 

NOTE: These will only work on gnome

```shell
sudo apt install gnome-tweaks chrome-gnome-shell gnome-shell-extensions
```
* then add the gnome extension to chrome [here](https://extensions.gnome.org/)

* if you want to use GnomeStatsPro or system-monitor extensions you need to run this too

```
sudo apt install gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0 gnome-system-monitor
```
* I Installed topicons, openweather, gnomestatspro, and system-monitor
***

## Addidtional Programs
I use some programs that use config files that I have set up in my [ubuntu_hacks repo](https://github.com/jacobmoroni/ubuntu_hacks)

```
sudo apt install zsh terminator guake
```

### VIM
install and setup vim with `./setupvim.sh` in repo
### ohmyzsh
* follow README instructions to set up ohmyzsh
### terminator
* follow README instructions to set up terminator
### guake
copy guake.desktop into autostart with  
```
cp /usr/share/applications/guake.desktop ~/.config/autostart/
```
* guake has an issue in ubunty 18.04 apt repo that causes it to crash when trying to exit. this is the fix
It's a Python indenting issue.
https://github.com/Guake/guake/commit/f8699b4be6c058fd58a33a1d783cd404e9076b0e

    * In current 18.04 package (guake 3.0.5-1), it's this file (line 1420):`/usr/lib/python3/dist-packages/guake/guake_app.py`
 (it wont be fixed in the apt repos)
***

## Set Up DroneHunter Repos
clone necessary repos
they can be found [here](https://fortemtech.atlassian.net/wiki/spaces/FT1/pages/737738784/DroneHunter+Repositories). 

* Dont forget to follow the readmes in the repos to set up correctly

* for java to work right in ubuntu 18.04 
```
sudo apt install openjdk-8-jdk openjdk-8-jre
```
* add these lines to you .bashrc or .zshrc
```
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin
```

[This is the resource for developer environment instructions](https://fortemtech.atlassian.net/wiki/spaces/FT1/pages/730923034/DroneHunter+Software+Dev+Environment+Setup)
***

## Install Slack
this adds slacke to the apt repos and adds it to start on boot
```shell
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb
```
```
sudo apt install ./slack-desktop-*.deb
```
```
cp /usr/share/applications/slack.desktop ~/.config/autostart 
```  
***

## Installing Jetbrains Programs
[This guy](https://github.com/JonasGroeger/jetbrains-ppa
) set up a ppa to get the latest so they just install and update with apt
To use, call this to add the repos

```
curl -s https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc | sudo apt-key add -
echo "deb http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com bionic main" | sudo tee /etc/apt/sources.list.d/jetbrains-ppa.list > /dev/null
```
```
sudo apt-get update
```

* then install them

```
sudo apt install clion intellij-idea-ultimate pycharm-community
```

then for intellij and pycharm when you set them up add the link to run from command line. 

To get the clion.desktop to build with ROS enabled. add this to the ~/.profile

    NOTE: This isnt working all the way for me, maybe a zshell thing?
```
source /opt/ros/melodic/setup.bash
source ~/workspaces/anansi_ros/devel/setup.bash --extend
```

I had a problem getting my CLion to build right in debug mode (breakpoints werent really working)
I eventually got it to work. I think it was looking at the normal ROS executables instead of the ones that clion makes. I think what fixed the problem is that I filled in the <kbd>settings -> Build, Execution, Depolyment -> CMAKE</kbd> generation path field with what is already greyed out in there. `cmake-build-debug`
***

## Install VSCODE
This adds the stable release to apt so it will install and update with apt
```
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
```
```
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
```
```
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
```
```
sudo apt update
```
```
sudo apt install code
```
***

## PIP packages that I use
```
pip install ipython pyqtgraph --user
```
***
