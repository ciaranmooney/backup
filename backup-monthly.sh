duplicity remove-all-inc-of-but-n-full 30 --force file:///media/backup
duplicity --exclude /home/*/.local/share/Trash /home file:///media/backup
duplicity cleanup --force
