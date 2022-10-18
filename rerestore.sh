#!/bin/bash
echo "Waiting while device is being restored...."
touch restore.log
./futurerestore282 -t ./files/blob.shsh2 --latest-sep --latest-baseband $1 >restore.log 2>&1

if [ $(tail restore.log | grep -c "Status: Restore Finished") == 0 ]; then
  exit 1
fi

exit 0
