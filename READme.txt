This script will autobackup a "directory/s" to an external drive
that is formatted to ntfs. It just makes sense, in my opinion to format 
an external drive to ntfs to be more versatile, it is practical.

NOTE!: Do not delete the created "USB-INFO" file, unless you're going to use a different drive.
Please edit the script and change the 6th line of the script to represent your path of this directory,
for the script to function correctly to obtain the info from the file created "USB-INFO"
This script is to only backup a single "directory/s" to
a specific(UUID) external drive only, and have a cron job run every * * * * *
to your liking. "It is sorta meant to be set it and forget it philosophy" 
More info can be found below.
https://www.thegeekstuff.com/2009/06/15-practical-crontab-examples/

Ex:
in terminal after running the script ./usb-backup.sh 
create a cron job with root/sudo
 
sudo crontab -e <<This command might ask you to select a text editor select nano
00 11,16 * * * /home/username/directoryname/AutoBackup/usb-backup.sh << add this line to the end of the file with YOUR info, modify it to YOUR liking. save and exit
                                                                        dont put a # in front of the command like so
                                                                        #00 11,16 * * * /home/username/directoryname/AutoBackup/usb-backup.sh
                                                                        00 11,16 * * * /home/username/directoryname/AutoBackup/usb-backup.sh <<just like this
