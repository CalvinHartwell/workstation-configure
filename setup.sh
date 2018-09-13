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
elif [ $OS = "Ubuntu" ]; then 
# Download and install packages for Ubuntu
sudo apt-get update
sudo apt-get install git vim texlive-full texmaker terminator gimp inkscape libreoffice alsa -y
sudo snap install kubectl
sudo snap install juju  
sudo snap install slack
sudo snap install helm 

# Configure git
git config --global user.name "calvinhartwell"
git config --global user.email "calvin@calvinhartwell.com"

# Download and configure up-to-date helm 
# Download and configure Google Chrome
# Download and configure Atom
# Download and configure Opera
# Download and configure NVIDIA drivers (if NVIDIA card present)
# Setup the Azure CLI tool
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

else
 echo "Not currently supported OS"
fi 

# Copy SSH Key (if present) into correct folder.
# Pull all my repos and put them into correct folder.
mkdir $HOME/Source
