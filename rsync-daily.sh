# Client backup script
# Ciarân Mooney
# 2018

# Check destination folder exists (ie wi-fi working, nfs working) 
#
# Log start time
# Backup small files first
rsync -rvz --exclude-from exclude-list.lst --times \
    --max-size=1M /home /mnt/backup
# Log end time
# Log start time
# Backup larger files second
rsync -rvz --exclude-from exclude-list.lst --times \
    --min-size=1M /home /mnt/backup
# Log end time
# Set complete flag

# -r - recursive
# -v - verbose
# -z - compress files during transfer
# --times - compare times and copy if file modified

