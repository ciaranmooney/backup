#!/bin/sh
# Install script for putting scripts in anacron folder.
# Ciarán Mooney
# 2019

cp backup-weekly /etc/cron.weekly/.
cp logrotate/cloudbackup /etc/logrotate.d/.  
cp logrotate/rsyncdaily /etc/logrotate.d/.


