#!/bin/bash
fan1=$(sensors it8792-isa-0a60 | grep "fan1" | awk '{print $2}')
fan3=$(sensors it8792-isa-0a60 | grep "fan3" | awk '{print $2}')
echo " Fans: $fan1 / $fan3"
