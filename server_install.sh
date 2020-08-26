#!/bin/sh
# Install script for putting scripts in anacron folder.
# Ciarán Mooney
# 2019

cp backup-inc /etc/cron.weekly/.
cp backup-full /etc/cron.monthly/.
cp logrotate/cloudbackup /etc/logrotate.d/.  
cp logrotate/rsyncdaily /etc/logrotate.d/.


