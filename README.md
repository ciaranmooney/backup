My backup stratergy for home laptop.

# Strategy

Using duplicity over WiFi network takes too long. It takes >24 hours after an 
initial test. To remove this bottle neck \home will be rsync'd directly to NFS 
share. Then duplicity will be run on the RaspberryPi NFS share to create 
archived backups. This has a dual benefit of a mirror backup available.

The client (Laptop) will backup small files first and then large files using
rysnc. Creating a mirror copy on the server. When both stages of the backup 
are comeplete a "complete" flag will be set. This tells the server, after 
a duplicity backup is finished, to delete the servers mirror copy. This will 
force the client to complete another full backup.

The server (RaspberryPi) will backup every week. This will be an incremental 
backup unless the complete flag is set. If the complete flag is set than the
server does a full backup. During the full backup if too many incremental
backups exist they are purged. Once a full backup is complete, the complete
flag is deleted along with the directory containing the rsync'd copy. 

The duplicity created backups can then be rclone'd off site (eg Google 
Nearline/Coldline). Note, only full duplicity backups will be copied to cloud
backup. Too many (large) incremental backups takes too long to upload.


# Client Install

* Run "install.sh"
 *  Moves rsync-daily to /etc/cron.daily/
 *  Moves exclude.lst to /opt
 *  Creates /var/log/backup
 *  XXX Creates log-rotate config
* Copy montly-backup.sh to Raspberry pi
* Create user "backup" with id 34. This is to match the backup user on
RaspberryPi, see:
[http://nfs.sourceforge.net/nfs-howto/ar01s07.html#pemission_issues]


# Server Config
## Files

* Mount USB drive with fstab entry.
> `UUID=f3e278c2-1043-4d4c-9440-e761d0a3aa77 /media/piDrive        ext4 defaults   0       2`
* Export the backup folder as an NFS share, modify /etc/exports.
> `/media/piDrive/UbuntuBackup     192.168.0.2(rw,no_subtree_check,all_squash,anonuid=34,anongid=34)`
Note, UID/GID 34 on default Raspbian is the backup user (intende1d for local)
* Make sure directory (UbuntuBackup) is owned by backup user (sudo chown -R backup:backup ..)
* Run `server_install.sh` to copy cron script and log rotation configuration. 
* Copy GPG to Raspberrypi and install on Root home directory
 * Import and edit pgp key ([https://stackoverflow.com/questions/\
33361068/gnupg-there-is-no-assurance-this-key-belongs-to-the-named-user])
> `gpg --import-key file.gpg986`
> `gpg --edit-key KEY_ID`
>  `gpg> trust` Choose "5" - I trust ultimately

# TODO

* Errors in duplicity are not caught and script carries on regardless, 
in the case of lack of space it deletes the backup flags etc. so the client
will start a full backup again.
* Add backup to Google Cloud of "large" files, UCL and Bham Uni backups, so
they don't get copied every day by rsync.

# Notes

* Initial rclone backup using throttling. Max upload speed of our internet
connection is 1.1 Mbit/s. Command below to run in background with limiting.
sudo rclone --bwlimit "08:00,0.5M 18:00,.1M 22:00,off" \
    -v sync /media/piDrive/UbuntuBackup/duplicity \
    remote:7c5d8617-a914-4916-b067-d4faf730fb6a 2> /tmp/cloud.log & 

# Troubleshooting

If rysnc gives "lack of space error", try rebooting the nfs service on the
raspberry pi. This is done by "sudo service nfs-kernel-server restart". The 
possbile solution to this is :
https://raspberrypi.stackexchange.com/questions/69839/\
    nfs-kernel-server-does-not-start-after-reboot
I have implemented the config file, we'll try later after a reboot.

If wireless router is changed (ISP changed) then you may need to reconfigure
either the fixed DHCP addresses for laptops and raspberrypi, and/or configure
/etc/fstab (client) and /etc/exports (server)
