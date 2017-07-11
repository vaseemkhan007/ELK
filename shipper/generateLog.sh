#!/bin/bash
TIMES=$1
FILENAME=$2
#for i in `seq 1 ${TIMES}`;
#do
#  while read line; do
#    echo "Adding line $line in /var/log/sample.log"
    #sleepTime=$(( $RANDOM % 2 ))
#    echo $line >> /var/log/${FILENAME}
    #sleep ${sleepTime}
#  done < /tmp/${FILENAME}
#  sleepTime=$(( $RANDOM % 200 ))
#  sleep ${sleepTime}
#done
for i in `seq 1 ${TIMES}`;
do

  lines=`wc -l /tmp/${FILENAME} | awk '{print $1}'`
  linesToRead=$(( $RANDOM % $lines ))
  echo "Sending lines ${linesToRead}"
  head -$linesToRead /tmp/${FILENAME} > /var/log/${FILENAME}
  sleepTime=$(( $RANDOM % 60 ))
  echo "Going into wait state for ${sleepTime}...."
  sleep ${sleepTime}
  echo "Woke up...."
done
