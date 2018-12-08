My backup stratergy for home laptop.

Strategy
--
Using duplicity over WiFi network takes too long. It takes >24 hours after an 
initial test. TO remove this bottle neck \home will be rsync'd directly to NFS 
share. Then duplicity will be run on the RaspberryPi NFS share to create 
archived backups. This has a dual benefit of a mirror backup available.

The duplicity created backups can then be rsync'd off site 
(eg Google Nearline/Coldline).

Install
--
- Edit sudo crontab to run each script, daily and monthly. See included crontab
example.
- Copy rync-daily.sh and exclude-list.lst to /opt.


Server Config
---
Files
* /etc/exports 
/media/piDrive/UbuntuBackup     192.168.0.2(rw,no_subtree_check,all_squash,anonuid=34,anongid=34)
Note, UID/GID 34 on default Raspbian is the backup user (intended for local)
* Make sure directory (UbuntuBackup) is owned by backup user (sudo chown -R backup:backup ..)
* Copy backup-daily.sh and backup-monthly.sh to /opt.

TODO
--
* Create a backup user on both the laptop and pi so the NFS can share it, see
[http://nfs.sourceforge.net/nfs-howto/ar01s07.html#pemission_issues] for why
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

