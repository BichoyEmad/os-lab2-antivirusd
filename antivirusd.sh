#!/bin/bash

MALICIOUS_EXTS=("exe" "bat" "vbs" "scr" "ps1")
MALICIOUS_TEXTS=("virus" "trojan" "malware" "worm" "ransomware")

isMaliciousExtension() {
   for malExt in "${MALICIOUS_EXTS[@]}" # [@] to expand array elements, not to check only first
   do
      if [ "$malExt" == "$1" ]
      then
         return 0
      fi
   done
   return 1
}

hasMaliciousText() {
   # Combine array elements "virus|malware|..."
   # -q to run quite
   # -i for case-insensitive
   # -E using Regex
   if grep -qi -E "$(IFS="|"; echo "${MALICIOUS_TEXTS[*]}")" "$1"
   then
      return 0
   fi
   return 1
}

handleMaliciousFile() {
   echo "$1 is malicious and it is DELETED"
   cp "$1" "$MALICIOUS_DIR/"
   rm "$1"
}

scanDir() {
   echo "Scanning files"
   for file in "$DIR"/*
   do
      echo "Checking $file"
      ext="${file##*.}"
      if isMaliciousExtension "$ext" || hasMaliciousText "$file"
      then
         handleMaliciousFile "$file"
      fi
   done
   echo "Scan finished"
}

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
      ls -l "$DIR" > directory-info.last
   fi
   sleep "$INTERVAL"
done
