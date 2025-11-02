#!/bin/bash
used=$(df -h /mnt/data | awk 'NR==2 {print $3}')
total=$(df -h /mnt/data | awk 'NR==2 {print $2}')
echo " RAID1: $used / $total"
