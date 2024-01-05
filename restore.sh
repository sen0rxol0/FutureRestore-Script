#!/usr/bin/env bash

if [ ! -d ./gaster ]
then
  git clone -q https://github.com/0x7ff/gaster.git
  cd gaster && make >/dev/null 2>&1;
  cd .. && chmod 755 gaster/gaster;
fi

if [ ! -d ./kairos ]
then
  git clone -q https://github.com/dayt0n/kairos.git
  cd kairos && make >/dev/null 2>&1;
  cd .. && chmod 755 kairos/kairos;
fi

if [ ! -e "/usr/local/bin/img4" ]
then
  echo "[EXITING] /usr/local/bin/img4 is missing."
  exit
fi

if [ ! -e ./kairos/kairos ] || [ ! -e ./gaster/gaster ];
then
  echo "[EXITING] ./kairos/kairos or ./gaster/gaster is missing."
  exit
fi

if [ ! -e /usr/local/bin/irecovery ]
then
  echo "[EXITING] /usr/local/bin/irecovery is missing."
  exit
fi

clear

if [ -z "$2" ] || [ -z "$1" ]
then
  echo "USAGE: $0 <Path to SHSH file> <Path to IPSW file>"
  exit
fi

shsh=$1

if [ ${shsh: -6} != ".shsh2" ] && [ ${shsh: -5} != ".shsh" ];
then
  echo "[EXITING] Ensure that SHSH file extension is either .shsh or .shsh2"
  exit    
fi

mv futurerestore308 futurerestore
xattr -d com.apple.quarantine futurerestore >/dev/null 2>&1
chmod +x futurerestore
chmod +x rerestore.sh
chmod +x main.sh
printf "\e[1;96m%s\e[0m\n" "SHSH nonce generator setter is starting"
sleep 5
./main.sh $1 $2

if [ $? -ne 0 ]
then
  echo "[EXITING] Device is not ready to be restored!"
  exit
fi

printf "\n"
echo "Done setting SHSH nonce generator to device"
echo "FutureRestore can now restore to the firmware version that SHSH is valid for!"
echo "Assuming that signed SEP and Baseband are compatible!"
printf "\e[1;96m%s\e[0m\n" "FutureRestore is starting"
sleep 5
./rerestore.sh $2

if [ $? -ne 0 ]
then
  echo "[EXITING] FutureRestore failed to restore device!"
  exit
fi

printf "\n"
sleep 2
printf "\e[1;96m%s\e[0m\n" "DONE!"
exit
