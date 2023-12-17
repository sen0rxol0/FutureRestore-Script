#!/usr/bin/env bash
echo "Waiting while device is being restored ..."
echo
touch restore.log
./futurerestore -t ./files/blob.shsh2 --latest-sep --latest-baseband -d $1 >restore.log 2>&1 &
# ./futurerestore -u -t ./files/blob.shsh2 --latest-sep --latest-baseband -d $1 >restore.log 2>&1 &
PID=$!
i=0
sp="/-\|"
sleep 5
printf " "

while [ $(ps -p $PID | grep -c "$PID") != 0 ]
do
  printf "\b%s" "${sp:i++%${#sp}:1}"
  sleep 0.1
done

printf "\n"

if [ $(tail restore.log | grep -c "Status: Restore Finished") == 0 ]; then
  exit 1
fi

exit 0
