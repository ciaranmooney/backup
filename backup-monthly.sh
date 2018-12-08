# Backup script for server
# Ciarân Mooney
# 2018

duplicity remove-all-inc-of-but-n-full 30 --force file:///mnt/backup
duplicity cleanup --force file:///mnt/backup
