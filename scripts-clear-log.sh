#!/bin/bash
echo '' > root/log-file.txt
find /home -type f -name "access_log"  > log-file.txt
input="/root/log-file.txt"
while IFS= read -r line
do
  echo '' > $line
done < "$input"
