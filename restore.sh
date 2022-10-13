#!/bin/bash

if [ -z $2 ]
then
  echo "USAGE: $0 <Path to SHSH file> <Path to IPSW file>"
  exit
fi

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

mv futurerestore282 futurerestore
xattr -d com.apple.quarantine irecovery 1> /dev/null
xattr -d com.apple.quarantine futurerestore 1> /dev/null
chmod +x irecovery
chmod +x futurerestore
chmod +x install.sh
chmod +x main.sh
clear
echo "Nonce-setter is starting"
sleep 5
./main.sh $1 $2

if [[ $? -ne 0 ]]
then
  echo "ERROR: Device is not ready to be restored!"
  exit
fi

clear
echo "Done setting SHSH nonce generator to device"
echo ""
echo "futurerestore can now restore to the firmware version that SHSH is valid for!"
echo "Assuming that signed SEP and Baseband are compatible!"
sleep 5
echo ""
echo "FutureRestore is starting"
sleep 5
./install.sh $2

if [ $? -ne 0 ]
then
  echo "ERROR: FutureRestore failed to restore device!"
  exit
fi

echo "DONE!"

