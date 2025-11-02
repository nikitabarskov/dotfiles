#!/bin/bash
# HDD temperatures for RAID drives
hdd1=$(cat /sys/class/hwmon/hwmon7/temp1_input 2>/dev/null || echo "0")
hdd2=$(cat /sys/class/hwmon/hwmon8/temp1_input 2>/dev/null || echo "0")
hdd1_c=$((hdd1 / 1000))
hdd2_c=$((hdd2 / 1000))
echo "${hdd1_c}°C / ${hdd2_c}°C"
