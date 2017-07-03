#!/bin/bash
TIMES=$1
FILENAME=$2
for i in `seq 1 ${TIMES}`;
do
  while read line; do
    date_time=`date -u | cut -d ' ' -f2-5`
    export date_time
    echo "Adding line $line in /var/log/sample.log"
    echo $line | sed "s/{{date_time}}/${date_time}/" >> /var/log/${FILENAME}
    #echo "$line" >> /var/log/${FILENAME}
  done < /tmp/${FILENAME}
done
