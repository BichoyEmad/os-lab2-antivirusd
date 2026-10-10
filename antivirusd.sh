#!/bin/bash

if [ $# -lt 3 ]
then
   echo "3 arguments are required: dir malicious_dir interval-secs"
   exit 1
fi

DIR=$1
MALICIOUS_DIR=$2
INTERVAL=$3

echo "Monitoring directory: $DIR"
echo "Malicious directory: $MALICIOUS_DIR"
echo "Checking every $INTERVAL seconds"

# before running first scan type directory-info
scanDir
ls -l $DIR > directory-info.last

while true
do
   # create new directory-info
   ls -l $DIR > directory-info.new
   if ! cmp -s directory-info.last directory-info.new
   then
      scanDir
      cp directory-info.new directory-info.last
   fi
   sleep "$INTERVAL"
done
