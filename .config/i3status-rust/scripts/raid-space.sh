#!/bin/bash
avail=$(df -h /mnt/data | awk 'NR==2 {print $4}')
total=$(df -h /mnt/data | awk 'NR==2 {print $2}')
echo " RAID1: $avail / $total"
