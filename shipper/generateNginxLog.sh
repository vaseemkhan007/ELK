#!/bin/bash
DAYS=$1
FILENAME=$2

echo "" > /var/log/${FILENAME}
for day in `seq 1 ${DAYS}`;
do
  nginxDatePattern=`date --date="$date -${day} day" +%d/%b/%Y`
  echo "Generating log file for ${nginxDatePattern}"
  lines=`wc -l /tmp/${FILENAME} | awk '{print $1}'`
  linesToRead=$(( $RANDOM % $lines ))
  echo "Sending lines ${linesToRead} out of ${lines}"
  head -$linesToRead /tmp/${FILENAME} | sed "s:{{date_pattern}}:${nginxDatePattern}:g" >> /var/log/${FILENAME}
done
