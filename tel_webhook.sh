#!/bin/bash
while true; do
usage_data="$(top -b -d 20 -n 2 -i | awk '$1 == "PID" {block_num++; next} block_num == 2 {sumCPU += $9; sumMEM += $10;} END {print "CPU USAGE: " sumCPU "  MEMORY USAGE: " sumMEM}')"
cpu_temp="$((cat /sys/class/thermal/thermal_zone*/temp) | sed 's/\(.\)..$/.\1°C/')"
curr_date="$(date)"
echo "hi"
curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X PATCH --data "{\"content\": \"$curr_date      $usage_data      CPU temp: $cpu_temp\"}" $(cat URL_TOKEN.txt)
done
