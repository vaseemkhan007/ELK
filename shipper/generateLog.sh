#!/bin/bash
TIMES=$1
FILENAME=$2
for i in `seq 1 ${TIMES}`;
do
  while read line; do
    echo "Adding line $line in /var/log/sample.log"
    sleepTime=$(( $RANDOM % 3 ))
    echo $line >> /var/log/${FILENAME}
    sleep ${sleepTime}
  done < /tmp/${FILENAME}
  sleepTime=$(( $RANDOM % 10 ))
  sleep ${sleepTime}
done
