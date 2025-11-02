#!/bin/bash
temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)
util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
echo " GPU: ${util}% ${temp}°C"

