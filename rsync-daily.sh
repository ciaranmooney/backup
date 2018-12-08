# Log start time
rsync -rvz --exclude-from exclude-list.lst --times \
    --max-size=1M /home /mnt/backup
# Log end time
# Log start time
rsync -rvz --exclude-from exclude-list.lst --times \
    --min-size=1M /home /mnt/backup
# Log end time

# -r - recursive
# -v - verbose
# -z - compress files during transfer
# --times - compare times and copy if file modified

