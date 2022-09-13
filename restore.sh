#!/bin/bash
xattr -d com.apple.quarantine futurerestore
chmod +x futurerestore
chmod +x install.sh
chmod +x main.sh
cd files
xattr -d com.apple.quarantine irecovery
chmod +x irecovery
cd ..
echo "*** FutureRestore Booter ***"
./main.sh
clear
echo "********* FutureRestore is Starting **********"
sleep 5
./install.sh
