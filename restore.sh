#!/usr/bin/env bash

if [ ! -d ./gaster ]
then
  git clone -q https://github.com/0x7ff/gaster.git
  cd gaster && git checkout 7fffffffd9753d927be21c093124a84084ecd6a8 >/dev/null 2>&1 && make >/dev/null 2>&1;
  cd .. && chmod 755 gaster/gaster;
  # xattr -d com.apple.quarantine gaster/gaster &> /dev/null
fi

if [ ! -d ./kairos ]
then
  git clone -q https://github.com/dayt0n/kairos.git
  cd kairos && make >/dev/null 2>&1;
  cd .. && chmod 755 kairos/kairos;
fi

if [ ! -e "/usr/local/bin/img4" ]; then
  curl --progress-bar -o img4lib.tar.gz -L https://github.com/xerub/img4lib/releases/download/1.0/img4lib-2020-10-27.tar.gz
  tar -xf img4lib.tar.gz
  mv img4lib/apple/img4 /usr/local/bin/ && mv img4lib/apple/libimg4.a /usr/local/lib/;
  rm -rf img4lib/ && rm img4lib.tar.gz;
  chmod 755 /usr/local/bin/img4
  xattr -d com.apple.quarantine /usr/local/bin/img4
fi

clear

if [ -z "$2" ]
then
  echo "USAGE: $0 <Path to SHSH file> <Path to IPSW file>"
  exit
fi

if [ -z "$1" ]
then
  echo "Drag and drop SHSH file into terminal:"
  read shsh
else
  shsh=$1
fi

if [ ${shsh: -6} != ".shsh2" ] || [ ${shsh: -5} != ".shsh" ];
then
  echo "[Exiting] Ensure that SHSH file extension is either .shsh or .shsh2"
  exit    
fi

mv futurerestore282 futurerestore
xattr -d com.apple.quarantine irecovery >/dev/null 2>&1
xattr -d com.apple.quarantine futurerestore >/dev/null 2>&1
chmod +x irecovery
chmod +x futurerestore
chmod +x rerestore.sh
chmod +x main.sh
printf "\e[1;96m%s\e[0m\n" "Nonce-setter is starting"
sleep 5
./main.sh $1 $2

if [ $? -ne 0 ]
then
  echo "[Exiting] Device is not ready to be restored!"
  exit
fi

clear
echo "Done setting SHSH nonce generator to device"
echo "FutureRestore can now restore to the firmware version that SHSH is valid for!"
echo "Assuming that signed SEP and Baseband are compatible!"
sleep 1
printf "\e[1;96m%s\e[0m\n" "FutureRestore is starting"
sleep 5
./rerestore.sh $2

if [ $? -ne 0 ]
then
  echo "[Exiting] FutureRestore failed to restore device!"
  exit
fi

clear
sleep 2
printf "\e[1;96m%s\e[0m\n" "DONE!"
exit
