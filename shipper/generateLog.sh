#!/bin/bash
TIMES=$1
for i in `seq 1 ${TIMES}`;
do
  while read line; do
    echo "Adding line $line in /var/log/sample.log"
    echo $line >> /var/log/sample.log
  done < /tmp/sample.log
done
