duplicity remove-all-inc-of-but-n-full 30 --force file:///mnt/backup
duplicity --exclude /home/*/.local/share/Trash /home file:///mnt/backup
duplicity cleanup --force file:///mnt/backup
