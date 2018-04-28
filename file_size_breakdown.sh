#!/bin/bash

find . -mtime +10  -type f -exec du {} \; > /tmp/files_10
find . -mtime +20 -mtime -10 -type f -exec du {} \; > /tmp/files_20
find . -mtime +30 -mtime -20 -type f -exec du {} \; > /tmp/files_30
find . -mtime +40 -mtime -30 -type f -exec du {} \; > /tmp/files_40

echo "Total size first 10 days"
cat /tmp/files_10 | xargs | sed 's/ /+/' | bc
echo "Total size first 20 days"
cat /tmp/files_20 | xargs | sed 's/ /+/' | bc
echo "Total size first 30 days"
cat /tmp/files_30 | xargs | sed 's/ /+/' | bc
echo "Total size first 40 days"
cat /tmp/files_40 | xargs | sed 's/ /+/' | bc
