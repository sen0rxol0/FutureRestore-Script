#!/bin/bash

color_red="\e[1;91m"
color_yellow="\e[1;93m"
color_blue="\e[1;96m"
color_reset="\e[0m"

_print_blue() {
printf "$color_blue****** %s$color_reset\n" "$1"
}

_print_red() {
printf "$color_red****** %s$color_reset\n" "$1"
}

_print_yellow() {
printf "$color_yellow****** %s$color_reset\n" "$1"
}

clear
rm -f ./files/*
shsh=$1
cp $shsh ./files/blob.shsh2

_print_yellow "Getting generator from SHSH"
generator=$(cat $shsh | grep "<string>0x" | cut -c10-27)

if [ -z "$generator" ]
then
    echo "SHSH saved with https://shsh.host (will show generator) or https://tsssaver.1conan.com (in noapnonce folder) are acceptable"
    _print_red "ERROR: SHSH does not contain a generator!"
    exit 3
fi

echo "SHSH generator is: $generator"
_print_blue "Please connect device in DFU mode."
read -p "Press ENTER when ready to continue <-"

device=$(./irecovery -q | grep "PRODUCT" | cut -f 2 -d ":" | cut -c 2-)

if [ -z "$device" ];then
    _print_red "ERROR: No device found."
    exit 2
fi

echo "Found device: $device"
_print_yellow "Extracting iBSS, iBEC files for device"
dir_tmp=/tmp/.futurerestore_script_staging
rm -rf $dir_tmp/
mkdir $dir_tmp
unzip -q $2 -x *.dmg -d $dir_tmp/

device_model=$(./irecovery -q | grep "MODEL" | cut -f 2 -d ":" | cut -c 2-)
manifest_index=0
ret=0
until [[ $ret != 0 ]]; do
  manifest=$(plutil -extract "BuildIdentities.$manifest_index.Manifest" xml1 -o - $dir_tmp/BuildManifest.plist)
  ret=$?
  if [ $ret == 0 ]; then
    count_manifest=$(echo $manifest | grep -c $device_model)
    if [ $count_manifest == 0 ]; then
      ((manifest_index++))
    else
      ret=1
    fi
  fi
done

if [ $ret != 1 ]
then
  exit 1
fi

_extractFromManifest()
{
    echo $(plutil -extract "BuildIdentities.$manifest_index.Manifest.$1.Info.Path" xml1 -o - $dir_tmp/BuildManifest.plist | xmllint -xpath '/plist/string/text()' -)
}

ibss=$(_extractFromManifest "iBSS")
ibec=$(_extractFromManifest "iBEC")
echo "iBSS: $ibss"
echo "iBEC: $ibec"
_print_yellow "Getting files ready to boot"
./gaster/gaster decrypt $dir_tmp/$ibss ./files/ibss.dec
./gaster/gaster decrypt $dir_tmp/$ibec ./files/ibec.dec
./kairos/kairos ./files/ibss.dec ./files/ibss.patched
./kairos/kairos ./files/ibec.dec ./files/ibec.patched -n
# Thanks to: https://github.com/Ralph0045/SSH-Ramdisk-Maker-and-Loader/blob/a2ad9a948342106a590bb5444694aa272a5cf1a0/Ramdisk_Maker.sh#L159
plutil -extract "ApImg4Ticket" xml1 -o - $shsh | xmllint -xpath '/plist/data/text()' - | base64 -D > ./files/apticket.der
img4 -i ./files/ibss.patched -o ./files/ibss.img4 -A -M ./files/apticket.der -T ibss
img4 -i ./files/ibec.patched -o ./files/ibec.img4 -A -M ./files/apticket.der -T ibec
_print_yellow "Entering PWNREC mode"
./irecovery -f ./files/apticket.der
./irecovery -f ./files/ibss.img4

if [ $(./irecovery -m | grep -c "Recovery") == 0 ]; then
  ./irecovery -f ./files/ibec.img4
fi

sleep 1
_print_blue "Entered PWNREC mode"
sleep 4
_print_yellow "Current nonce"
./irecovery -q | grep "NONC"
echo "Setting nonce to $generator"
./irecovery -c "setenv com.apple.System.boot-nonce $generator"
sleep 1
./irecovery -c "saveenv"
sleep 1
./irecovery -c "setenv auto-boot false"
sleep 1
./irecovery -c "saveenv"
sleep 1
./irecovery -c "reset"
_print_yellow "Waiting for device to restart into recovery mode"
sleep 7
_print_yellow "New nonce"
./irecovery -q | grep "NONC"

exit 0
