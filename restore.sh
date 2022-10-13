#!/bin/bash

if [ ! -d ./gaster ]
then
  git clone -q https://github.com/0x7ff/gaster.git
  cd gaster && make 1> /dev/null;
  cd ..
  chmod 755 gaster/gaster
  # xattr -d com.apple.quarantine gaster/gaster 1> /dev/null
fi

if [ ! -d ./kairos ]
then
  git clone -q https://github.com/dayt0n/kairos.git
  cd kairos && make 1> /dev/null;
  cd ..
  chmod 755 kairos/kairos
fi

if [ ! -e "/usr/local/bin/img4" ]; then
  curl --progress-bar -o img4lib.tar.gz -L https://github.com/xerub/img4lib/releases/download/1.0/img4lib-2020-10-27.tar.gz
  tar -xf img4lib.tar.gz
  mv img4lib/apple/img4 /usr/local/bin/ && mv img4lib/apple/libimg4.a /usr/local/lib/;
  rm -rf img4lib/ && rm img4lib.tar.gz;
  chmod 755 /usr/local/bin/img4
  xattr -d com.apple.quarantine /usr/local/bin/img4
fi

if [ -z "$2" ]
then
  echo "USAGE: $0 <Path to SHSH file> <Path to IPSW file>"
  exit
fi

if [ -z "$1" ]
then
  echo "Please drag and drop SHSH file into terminal:"
  read shsh
else
  shsh=$1
fi

if [ ${shsh: -6} == ".shsh2" ] || [ ${shsh: -5} == ".shsh" ];
then
    echo "SHSH file verified as valid, continuing ..."
else
    echo "[Exiting] Please ensure that the file extension is either .shsh or .shsh2 and retry"
    exit
fi

mv futurerestore282 futurerestore
chmod +x irecovery
chmod +x futurerestore
chmod +x install.sh
chmod +x main.sh
printf "\e[1;96m%s\e[0m\n" "Nonce-setter is starting"
sleep 5
./main.sh $1 $2

if [ $? -ne 0 ]
then
  echo "ERROR: Device is not ready to be restored!"
  exit
fi

clear
echo "Done setting SHSH nonce generator to device"
echo "futurerestore can now restore to the firmware version that SHSH is valid for!"
echo "Assuming that signed SEP and Baseband are compatible!"
sleep 5
echo ""
printf "\e[1;96m%s\e[0m\n" "FutureRestore is starting"
sleep 5
./install.sh $2

if [ $? -ne 0 ]
then
  echo "ERROR: FutureRestore failed to restore device!"
  exit
fi

printf "\e[1;96m%s\e[0m\n" "DONE!"
