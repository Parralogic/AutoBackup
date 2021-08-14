#!/bin/bash
#Creator: David Parra-Sandoval                                                                                                                                                                     
#Date: 02/27/2021
#Last Modified: 08/14/2021
clear
cd /home/david/Git/AutoBackup/
if [[ ${UID} != 0 ]]; then
echo "Please run as root/sudo!"
exit 1
fi
while true; do
DRIVE=$(cat USB-INFO | cut -d '"' -f 2)
NAME=$(cat USB-INFO | cut -d " " -f 1)
ID=$(cat USB-INFO | cut -d " " -f 2)
DRIVEBD=$(cat USB-INFO | cut -d " " -f 3)
BD=$(cat USB-INFO | cut -d " " -f 4)
#MOUNT=$(blkid | grep $DRIVE | cut -d "/" -f3 | cut -d ":" -f 1)
MOUNTDRIVE=$(blkid | grep $DRIVE | cut -d " " -f 1 | cut -d ":" -f 1)
 root () {
 while true; do
sudo mount $MOUNTDRIVE /mnt
 if [[ $(blkid | grep "$DRIVE" | cut -d " " -f 4) = $ID ]]; then          #Debian/Ubuntu Distro change the 4 to 3
sudo cp -rvu $BD/* /mnt && clear
exit 0
else
xmessage -nearmouse "Please insert correct drive with $ID : $NAME, $BD will not be BACKED UP!" &
echo -e "\e[91mUUID of drive don't match!"
echo "Please insert correct drive with UUID of $ID"
sleep 6; clear
kill $!
fi
done

 }

if [[ ! -e USB-INFO ]]; then


until [[ $YESNO = [yY]* ]]; do
clear
echo -e "\e[92mWhat's the external USB drive to backup to:?\e[00m"
lsblk
read -p "Only input sda{1..3}, sdb{1..3}, sdc{1..3}.... etc: " USBDRIVE
read -p "$USBDRIVE will be used:? [y/n] " YESNO
done
case $YESNO in
y|Y ) echo -e "\e[91m$USBDRIVE will be mounted to the mnt directory\e[00m"
sudo mount /dev/$USBDRIVE /mnt
sleep 2
USBID=$(blkid | grep "$USBDRIVE" | cut -d " " -f 4)   #Debian/Ubuntu Distro change 4 to 3
LABEL=$(blkid | grep "$USBDRIVE" | cut -d " " -f 2)
cd /mnt
clear
ls
echo
echo -e "\e[91mBackup to the root of the USB drive or create a NEW directory for the backup?\e[00m"
select BACKUPATH in root NEWdirectory; do
case $BACKUPATH in
root ) NEWDIRECTORY=root; break ;;
NEWdirectory ) read -p "Name of the NEW directory: " NEWDIRECTORY
sudo mkdir $NEWDIRECTORY
break ;;
esac
done
cd $OLDPWD
;;
esac
until [[ $BACKUP = [yY]* ]]; do
clear
echo -e "\e[91mUse the full absolute path! Ex:/var/log or $HOME/backupdirectory\n\e[00m"
read -p "What's the path of the directory containing the files to backup:? " BACKUPDIRECTORY
read -p "[$BACKUPDIRECTORY] will be used:? [y/n] " BACKUP
echo "$LABEL $USBID $NEWDIRECTORY $BACKUPDIRECTORY" > USB-INFO
done
case $NEWDIRECTORY in
root)
sudo cp -rvu $BACKUPDIRECTORY/* /mnt && clear;;
*)
sudo cp -rvu $BACKUPDIRECTORY /mnt/$NEWDIRECTORY && clear ;;
esac
else
if [[ $DRIVEBD = root ]]; then
root
fi
sudo mount $MOUNTDRIVE /mnt
while true; do
if [[ $(blkid | grep "$DRIVE" | cut -d " " -f 4) = $ID ]]; then          #Debian/Ubuntu Distro change the 4 to 3
sudo cp -rvu $BD /mnt/$DRIVEBD && clear
break
else
xmessage -nearmouse "Please insert correct drive with $ID : $NAME, $BD will not be BACKED UP!" &
echo -e "\e[91mUUID of drive don't match!"
echo "Please insert correct drive with UUID of $ID"
sleep 6; clear
kill $!
fi
done
fi
sleep 60
done
