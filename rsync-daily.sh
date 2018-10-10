rsync -rvz --exclude-from exclude-list.lst --times /home /mnt/backup

# -r - recursive
# -v - verbose
# -z - compress files during transfer
# --times - compare times and copy if file modified
#
