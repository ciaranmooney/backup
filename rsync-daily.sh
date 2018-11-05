rsync -rvz --exclude-from exclude-list.lst --times /home /mnt/backup
rsync -rvz --exclude-from exclude-list.lst --times \
    --max-size=1M /home /mnt/backup
rsync -rvz --exclude-from exclude-list.lst --times \
    --min-size=1M /home /mnt/backup

# -r - recursive
# -v - verbose
# -z - compress files during transfer
# --times - compare times and copy if file modified
#
