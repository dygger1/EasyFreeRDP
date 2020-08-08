#!/bin/bash
# A script used to install xFreeRDP Connect's prerequisites based on the current Distro
# must be run with sudo

if [[ $EUID -ne 0 ]]; then
   echo "The script must be run with sudo"
   exit 2
fi

echo -e "
======================================================
 Updating your system and installing required packages
======================================================
"
read -p "Continue? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

#Get distro
DISTRO=`grep -ihs "buntu\|SUSE\|Fedora\|Debian\|CentOS\|Red Hat Enterprise Linux Server\|Arch\|Manjaro" /etc/{issue,*release}`
case $DISTRO in
	Arch*)
                echo 'Arch Linux detected. Installing required packages...'
                #Update system and install required software
                pacman -Syu --noconfirm
                pacman -S freerdp zenity --needed --noconfirm
;;
        Manjaro*)
                echo 'Manjaro Linux detected. Installing required packages...'
                #Update system and install prerequisites
                pacman -Syu --noconfirm
                pacman -S freerdp zenity --needed --noconfirm
;;     
        *buntu*)
                echo 'Ubuntu detected. Installing required packages...'
                apt update
                apt install -y freerdp-x11 zenity
;;
        Debian*)
		echo 'Debian detected. Installing required packages...'
                apt update
                apt install -y freerdp-x11 zenity
;;
        *Mint*)
		echo 'Linux Mint detected. Installing required packages...'
                apt update
                apt install -y freerdp-x11 zenity
;;
        Fedora*)
		echo 'Fedora detected.Installing required packages...'
		dnf update
                dnf install -y snapd
                ln -s /var/lib/snapd/snap /snap
                snap install zenity
                dnf install -y freerdp
;;
	*SUSE*)
		echo 'SUSE detected.Installing required packages...'
		zypper --non-interactive update
                zypper --non-interactive install zenity freerdp
;;
        Red\sHat\sEnterprise\sLinux\sServer*|CentOS*)
		echo 'CentOS detected. Installing required packages...'
		yum update -y 
                yum install -y zenity freerdp
;;
esac

echo -e "
======================================================
 Updating your system and installing required packages
======================================================
"
read -p "Continue? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi