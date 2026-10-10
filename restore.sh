#!/bin/bash

if [ $# -lt 2 ]
then
   echo "2 arguments are required: dir malicious_dir"
   exit 1
fi

DIR=$1
MALICIOUS_DIR=$2

   if [ -z "$(ls -A "$MALICIOUS_DIR")" ] #-z is zero chars string
   then
      echo "No malicious files to review."
      exit 0
   fi

while true
do
   index=1
   files=("$MALICIOUS_DIR"/*)
   for file in "${files[@]}"
   do
      echo "$index: $file"
      ((index++))
   done
   echo "Select file: (-1 to exit)"
   read sel
   if [ "$sel" -eq -1 ]
   then
      exit 0
   fi
   selected="${files[$((sel - 1))]}"
   echo "1: Restore this file back into dir (it was a false positive)"
   echo "2: Permanently delete this file from malicious_dir (it was genuinely malicious)"
   echo "3: Leave this file as-is and go back to the list"
   read action
   if [ "$action" -eq 1 ]
   then
      cp "$selected" "$DIR/"
      rm "$selected"
      echo "Restored $selected to $DIR."
   fi
   if [ "$action" -eq 2 ]
   then
      rm "$selected"
      echo "$selected permanently deleted."
   fi
done
