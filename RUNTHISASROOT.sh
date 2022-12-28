#!/bin/bash
export cprt=0
echo --------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------
echo ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ Zoneminder Install Script ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ 
echo ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ by @justaCasualCoder ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎
echo --------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------‎ 
echo ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ 
echo ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ 
echo ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ 
export cprt=1
DIR=$( pwd; )
USER=$(whoami)
Red=$'\e[1;31m'
Green=$(tput setaf 2)
if [ '$1'  =  '-m' ];
then
sudo ./ZoneminderInstallGUI.sh
sleep 1
exit 0
fi
if [ "$?" != "1" ];
then
sudo dnf install lsb_release
fi
sudo apt-get -y install lsb-release
if [ "$?" != "1" ];
then
sudo yum -y install lsb-release
fi
if [ "$?" != "1" ];
then
sudo pacman -Sy --noconfirm
sudo pacman -S lsb_release --noconfirm
fi

lsb_release -a | grep -qe buntu
if [ "$?" = "0" ];
then 
OS=Ubuntu
fi
lsb_release -a | grep -qe Fedora
if [ "$?" = "0" ];
then 
OS=Fedora
fi
if [ -f "/etc/SuSE-release" ]; then
OS=OpenSuSE
fi
lsb_release -a | grep -qe Arch
if [ "$?" = "0" ];
then 
OS="Arch Linux"
fi
lsb_release -a | grep -qe Debian
if [ "$?" = "0" ];
then
OS=Debian
fi
OS='Ubuntu'
if [ -z "$OS" ]
then
      echo "$Red !ERROR!" "Your OS could not be detected; the manual GUI OS picker will start"
      ./ZoneminderInstallGUI.sh
else
      echo  Your OS is $OS
fi
if [ $OS = 'Arch Linux' ];
then
sudo pacman -Qe | grep 'yay' &> /dev/null
if [ $? == 0 ]; then
   echo "$Green Yay Is already installed!"
else 
sudo pacman -Syu
sudo pacman -S git --noconfirm
sudo pacman -S fakeroot --noconfirm
sudo pacman -S make --noconfirm
cd /opt
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R $USER:$USER ./yay-git
cd yay-git
makepkg -si --noconfirm
sudo chmod +x Arch\ Linux\ install.sh
sudo ./Arch\ Linux\ Install.sh  
fi
fi
OS=Ubuntu
echo $OS
if [[ $OS = 'Ubuntu' ]]
then
    echo "Are you running this script on Ubuntu Server or Desktop? ( Type Server for Server and Desktop for Desktop)"
    sleep 3
    read answer2
    if [ "$answer2" = "Server" ]; then
    
    sudo chmod +x ZoneminderUBUNTUSERVERINSTALL.sh
    sudo ./ZoneminderUBUNTUSERVERINSTALL.sh
    else
    sudo chmod +x UbuntuZoneminderGUIinstall.sh
    sudo ./UbuntuZoneminderGUIinstall.sh
    fi
fi 
if [ $OS = 'Fedora' ]; then
echo "Are you running this script on Fedora Server or Desktop? ( Type Server for Server and Desktop for Desktop"
read answer2
    if [ "$answer2" = "Server" ]; then
    sudo chmod +x FedoraServerInstall.sh
    sudo ./FedoraServerInstall.sh
    else
    sudo chmod +x installzoneminderREDHATGENERAL.sh
    sudo ./installzoneminderREDHATGENERAL.sh
fi
if [ "$OS" = "OpenSuSE" ]; then
    sudo chmod +x RHEL-Centos7-installerzoneminder.sh
    sudo ./RHEL-Centos7-installerzoneminder.sh
fi
if [ "$OS" = "Debian" ]; then
    sudo chmod +x DebianZoneminderInstaller.sh
    sudo ./DebianZoneminderInstaller.sh
fi
echo "You chose $OS as your OS"
fi
