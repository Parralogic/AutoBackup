This script will autobackup a "directory/s" to an external drive
that is formatted to ntfs. It just makes sense, in my opinion to format 
an external drive to ntfs to be more versatile, it is practical.
Please insert the drive that is going to be used to backup first, then run script.
****Do not mount the drive or auto-mount the drive!

NOTE!: Do not delete the created "USB-INFO" file, unless you're going to use a different drive.
Please edit the script and change the 6th line of the script to represent your path of this directory,
for the script to function correctly to obtain the info from the file created "USB-INFO"
This script is to only backup a single "directory/s" to
a specific(UUID) external drive only, and have a cron job run every * * * * *
to your liking. "It is sorta meant to be set it and forget it philosophy" 
More info can be found below.
https://www.thegeekstuff.com/2009/06/15-practical-crontab-examples/

Ex:
in terminal after running the script [sudo ./usb-backup.sh] 
create a cron job with root/sudo
**Needs to be executed as a root/sudo user because of the mount command and blkid command
 
sudo crontab -e <<This command might ask you to select a text editor select nano
00 11,16 * * * /home/username/directoryname/AutoBackup/usb-backup.sh << add this line to the end of the file with YOUR info, modify it to YOUR liking. save and exit
                                                                        dont put a # in front of the command like so
                                                                        #00 11,16 * * * /home/username/directoryname/AutoBackup/usb-backup.sh
                                                                        00 11,16 * * * /home/username/directoryname/AutoBackup/usb-backup.sh <<just like this
                     
08/14/2021 TIPS:
Check status of cronie/crond if its running; in terminal execute: systemctl status cronie or systemctl status crond
If not enabled, enable cronie by executing: systemctl enable cronie or systemctl enable crond. Once enabled best to restart pc, just to make sure its enabled.
REMEMBER! change the 6th line in the script to represent the path of this directory corresponding to your system!.
FYI, While the cron job is running in the background, and you happen to accidentally change a document and saved it, but those
changes are too much, remember you do have a backup on the drive! remove/unplug the drive immediately! because if you dont it will update the file
on the drive! with the changes YOU accidentally made, that you dont want. Make sure you know how often the cron job will execute the script! 
also try running the script by itself sudo ./usb-backup.sh to make sure you have the right drive for the backup!, You will get a pop-up message alerting you
to insert the correct drive, once the correct drive for the backup has been inserted the message will terminate.

IF you don't wanna worry about setting up a cron job, just run the usb-backupWtimer.sh script it has a built in timer, just edit the script, change the 6th line, scroll to the bottom and change the sleep count to however many seconds the script should re-execute. just dont close the terminal, NOTE! if using this method script will ONLY! backup to a NEWdirectory not to the root of the drive!. If you set the sleep count to 600 it would re-execute the script every 10 minutes 60x10=600.
make usb-backupWtimer.sh executable [chmod +x usb-backupWtimer.sh] in terminal. REMEMBER! dont close the terminal, just minimize the terminal, to make sure its working just unplug{not recommended}/safely unmount/safely remove the drive, and wait to see if you get a pop-up asking to insert the drive.
DON'T close the terminal! Only when you know that everything has been backed up and you no longer need the script to run in the "background". And YES!
remember the seconds/min YOU inputted, because, again if you make a change that you don't want it will update the file on the drive!

NOTE!: IF you delete a file on the directory you are backing up, the file will not be deleted on the drive!, IF it had already been backed UP.
