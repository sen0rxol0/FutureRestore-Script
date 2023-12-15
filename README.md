# How to restore iOS device to same firmware version ...

- Download SSHRD_Script
- Boot ramdisk
- Dump SHSH blob file
- Download IPSW restore file
- Start FutureRestore Script

## [FutureRestore Script](https://github.com/sen0rxol0/FutureRestore-Script)

### Supported Devices:
- A7 - A11
 
### Requirements:

- SHSH blob file.
- IPSW file with the same firmware version as SHSH.
- macOS system.

### How to use:

1. Clone this git repository

2. Open the Terminal `cd` into directory and then run:

```
chmod +x restore.sh 
```

```
./restore.sh <SHSH> <IPSW>
```
e.g
```
./restore.sh ~/Downloads/15.7-19H12.shsh2 ~/Downloads/15.7_19H12_Restore.ipsw
```

### Note:

Make sure the SEP is compatible with the firmware version being restored.

> WARNING: This restore will erase your device data.

### Credits:

MatthewPierson/Checkm8-nonce-setter

tihmstar/FutureRestore

80036nd/FutureRestore-Script

xerub/img4lib

0x7ff/gaster

dayt0n/kairos
