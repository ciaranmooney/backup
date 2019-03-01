#!/bin/sh
# Transfers server scripts to my raspberrypi. Note, only moves them to the home
# directories.
# Ciarán Mooney
# 2019

scp backup-weekly pi@raspberrypi.local:~/.
scp cloud-backup pi@raspberrypi.local:~/.


