# FutureRestore Script

## Supported Devices:
- iPhone 5s
- iPhone 7 (Plus)
- iPhone 8 (Plus)
- iPhone X
- iPad Air 1
- iPad Mini 2
- iPad 6th Gen (2018)
- iPad Mini 3
- iPad 7th Gen (2019)
- iPod Touch 7th Gen (2019)

## Requirements:

- SHSH blob file from a SHSH Blobs saver.
- Downloaded IPSW file with same firmware version as the saved SHSH blob.
- macOS system

## How to use:

1. Clone this git repository

2. Open the Terminal `cd` into directory and then run:

```
chmod +x restore.sh 
./restore.sh <SHSH> <IPSW>
```

## Note:

Make sure the SEP is compatible with the firmware version being restored.

> WARNING: This restore will erase your device data.

## Credits:

MatthewPierson for the Checkm8-nonce-setter

tihmstar for FutureRestore

80036nd for this tool ;)

xerub for img4lib

0x7ff for gaster

dayt0n for kairos
