## FutureRestore Script

### Supported Devices:
- A7 - A11
 
### Requirements:

- SHSH blob file from a SHSH Blobs saver.
- IPSW file with same firmware version as the saved SHSH blob.
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

MatthewPierson for the Checkm8-nonce-setter

tihmstar for FutureRestore

80036nd for this tool ;)

xerub for img4lib

0x7ff for gaster

dayt0n for kairos

sen0rxol0 for this fork
