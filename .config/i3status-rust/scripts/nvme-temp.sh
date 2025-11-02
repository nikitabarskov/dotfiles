#!/bin/bash
# NVMe temperature for root SSD (nvme0n1)
temp=$(cat /sys/class/hwmon/hwmon1/temp1_input)
temp_c=$((temp / 1000))
echo "${temp_c}°C"
