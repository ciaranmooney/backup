My backup stratergy for home laptop.

Install
--

Server Config
---
Files
* /etc/exports 
/media/piDrive/UbuntuBackup     192.168.0.2(rw,no_subtree_check,all_squash,anonuid=34,anongid=34)
Note, UID/GID 34 on default Raspbian is the backup user (intended for local)
* Make sure directory (UbuntuBackup) is owned by backup user (sudo chown -R backup:backup ..)


TODO
--
* Create a backup user on both the laptop and pi so the NFS can share it, see
[http://nfs.sourceforge.net/nfs-howto/ar01s07.html#pemission_issues] for why
* Cron needs to run as backup user
* Create and securely store a GPG key (ie offline, printout). The key will be
backed up in an encrypted file. If the key is lost from the laptop, recovery
will not be possible

