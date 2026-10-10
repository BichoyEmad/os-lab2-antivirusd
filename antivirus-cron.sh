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

if [ $# -lt 2 ]
then
   echo "2 arguments are required: dir malicious_dir"
   exit 1
fi

DIR=$1
MALICIOUS_DIR=$2

scanDir
