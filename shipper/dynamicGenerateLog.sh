#!/bin/bash
TIMES=$1
FILENAME=$2
for i in `seq 1 ${TIMES}`;
do
  while read line; do
    date_time=`date -u | cut -d ' ' -f2-5`
    export date_time
    echo "Adding line $line in /var/log/sample.log"
    sleepTime=$(( $RANDOM % 3 ))
    echo $line | sed "s/{{date_time}}/${date_time}/" >> /var/log/${FILENAME}
    sleep ${sleepTime}
  done < /tmp/${FILENAME}
  sleepTime=$(( $RANDOM % 10 ))
  sleep ${sleepTime}
done
