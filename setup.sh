#!/usr/bin/env bash

# Check which OS is being used 
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

# Download and install packages for RHEL/CentOS/Fedora
if [ $OS = "CentOS" ]; then
  echo "Not Currently supported OS" 
  # add EPEL 
  # Install Packages
elif [ $OS = "Ubuntu" ]; then 
# Download and install packages for Ubuntu
sudo apt-get update
sudo apt-get remove chronyd
sudo apt-get install git fluxbox ntp vim tree wget curl texlive-full texmaker terminator gimp inkscape libreoffice alsa irssi quassel -y
sudo snap install kubectl
sudo snap install juju  
sudo snap install slack
sudo snap install helm 

# Configure git for my user. 
git config --global user.name "calvinhartwell"
git config --global user.email "calvin@calvinhartwell.com"

# Download and configure kvm, libvirt, virsh, virtmanager etc. 
sudo apt install cpu-checker -y
sudo apt install qemu qemu-kvm libvirt-bin  bridge-utils  virt-manager -y

# Download and configure Wine
# Download and configure Virtual-Box

# Download and configure up-to-date helm 
# Download and configure Google Chrome
sudo wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
t -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update 
sudo apt-get install google-chrome chrome -y

# Download and Install ATOM 
sudo wget -O atom.deb https://atom.io/download/deb

# Download and configure Visual Studio Code
# Download and install Java (ugh)
# Download and configure Opera
sudo add-apt-repository 'deb https://deb.opera.com/opera-stable/ stable non-free'
wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install opera-stable -y

# Download and configure NVIDIA drivers (if NVIDIA card present)
# Blacklist the regular driver if required. 

# Change default pulseaudio/alsa sample rate and format in /etc/pulse/daemon.conf
#  defaults 
# ; default-sample-format = s16le
# ; default-sample-rate = 44100
# Possible entries for the sample format are:  u8, s16le, s16be, s24le, s24be, s24-32le, s24-32be, s32le, s32be float32le, float32be, ulaw, alaw
# Possible entries for the sample frequency are anything between 1 and 192000 Hz (choose sensible values!)
sudo sed -i 's/; default-sample-format = s16le/default-sample-format = s32le/g' /etc/pulse/daemon.conf
sudo sed -i 's/; default-sample-rate = 44100/default-sample-rate = 192000/g' /etc/pulse/daemon.conf
pulseaudio -k 

# TODO: Apply hardening to OS for security purposes...

else
 echo "Not currently supported OS"
fi 

# Copy SSH Key (if present) into correct folder.
mkdir ~/.ssh/
cp id_rsa id_rsa.pub ~/.ssh/

# Pull all my repos and put them into correct folder.
mkdir $HOME/Source

# Setup the Azure CLI tool for Azure juju provisioning
curl -L https://aka.ms/InstallAzureCli | bash
