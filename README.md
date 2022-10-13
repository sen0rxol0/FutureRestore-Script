# FutureRestore Script

## Supported Devices:
- iPhone 5s
- iPhone 7
- iPhone 7 Plus
- iPhone X
- iPad Air 1
- iPad Mini 2
- iPad 6th Gen (2018)
- iPad Mini 3
- iPad 7th Gen (2019)
- iPod Touch 7th Gen (2019)

## How to use:

1. Have a SHSH blob from a SHSH Blobs saver ready

2. Download a IPSW with same firmware version as the saved SHSH blob

3. Clone this git repository

4. Open the Terminal `cd` into directory and then run:

```
chmod +x restore.sh 
./restore.sh <SHSH> <IPSW>
```

## Note:

Make sure the SEP is compatible with the firmware version you are trying to restore.

> WARNING: This will wipe all of your data.

## Credits:

MatthewPierson for the Checkm8-nonce-setter

Tihmstar for FutureRestore

80036nd for this tool ;)
