#!/bin/sh

cp exclude-list.lst /opt/.
cp rsync-daily /etc/cron.daily/.
cp logrotate/rsyncdaily /etc/logrotate.d/.

# mkdir /var/log/backup
# Create logrotate configuration files.
