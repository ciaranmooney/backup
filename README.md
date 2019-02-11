My backup stratergy for home laptop.

Strategy
--
Using duplicity over WiFi network takes too long. It takes >24 hours after an 
initial test. TO remove this bottle neck \home will be rsync'd directly to NFS 
share. Then duplicity will be run on the RaspberryPi NFS share to create 
archived backups. This has a dual benefit of a mirror backup available.

The client (Laptop) will backup small files first and then large files using
rysnc. Creating a mirror copy on the server. When both stages of the backup 
are comeplete a "complete" flag will be set. This tells the server, after 
a duplicity backup is finished, to delete the servers mirror  copy. This will 
force the client to complete another full backup.

The server (RaspberryPi) will backup incrementally (every day) and fully
(week) using Duplicity. If the server completes a full backup and finds a
"Complete" flag. It wipes the total contents.

The duplicity created backups can then be rsync'd off site 
(eg Google Nearline/Coldline).

Install
--
- Run "install.sh"
-- Moves rsync-daily to /etc/cron.daily/
-- Moves exclude.lst to /opt
-- Creates /var/log/backup
-- XXX Creates log-rotate config
- Copy montly-backup.sh to Raspberry pi
- Create user "backup" with id 34. This is to match the backup user on
RaspberryPi, see:
[http://nfs.sourceforge.net/nfs-howto/ar01s07.html#pemission_issues]


Server Config
---
Files
* /etc/exports 
/media/piDrive/UbuntuBackup     192.168.0.2(rw,no_subtree_check,all_squash,anonuid=34,anongid=34)
Note, UID/GID 34 on default Raspbian is the backup user (intended for local)
* Make sure directory (UbuntuBackup) is owned by backup user (sudo chown -R backup:backup ..)
* Copy backup-monthly.sh to /opt.

TODO
--
* Cron needs to run as backup user
* Create and securely store a GPG key (ie offline, printout). The key will be
backed up in an encrypted file. If the key is lost from the laptop, recovery
will not be possible
* rysnc seems to work but takes just less than 24 hours for a full backup. May 
be worth segregating small, medium and large files.


Troubleshooting
--

If rysnc gives "lack of space error", try rebooting the nfs service on the
raspberry pi. This is done by "sudo service nfs-kernel-server restart".

