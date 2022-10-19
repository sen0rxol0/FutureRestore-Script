# FutureRestore Script

## Supported Devices:
- iPhone (5/5s/6/6s/6s+/SE/7/7+/8/8+/X)
- iPad Air (1/2)
- iPad Mini (2/3/4)
- iPad (6th Gen/7th Gen/Pro)

Maybe other devices not listed to ;)
 
## Requirements:

- SHSH blob file from a SHSH Blobs saver.
- Downloaded IPSW file with same firmware version as the saved SHSH blob.
- macOS system.

## How to use:

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

## Note:

Make sure the SEP is compatible with the firmware version being restored.

Make sure device has Baseband (SIM capability).

> WARNING: This restore will erase your device data.

## Credits:

MatthewPierson for the Checkm8-nonce-setter

tihmstar for FutureRestore

80036nd for this tool ;)

xerub for img4lib

0x7ff for gaster

dayt0n for kairos

sen0rxol0 for the improvement
