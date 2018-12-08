# Backup script for server
# Ciarân Mooney
# 2018

duplicity remove-all-inc-of-but-n-full 30 --force file:///mnt/backup
duplicity cleanup --force file:///mnt/backup
# Check for "Complete" flag, ie a complete backup has been done.
# Delete contents of source directory to allow new complete backup
