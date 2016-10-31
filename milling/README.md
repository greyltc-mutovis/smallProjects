Aluminum:
6061-T6511

Cutter:
KODIAK149946

Al supplier:
http://www.durbinmetals.co.uk/

Cutting tool supplier:
indtech

### Firmware
One weird trick to getting through the bootloader with avrdude on the Carbidemotion v2.3 PCB that shipped with our shapoko3:

1. hold little switch below capacitor, not letting go. (just press on the giant through hole cap, you'll feel the click)
1. press and quickly release reset button on PCB
1. do avrdude command
1. release capacitor button
1. profit

Use avrdude to dump S3 firmware to `dumpedFirmware.hex` (in Intel hex format):
```bash
avrdude -n -p m328p -P /dev/ttyACM0 -c arduino -U flash:r:dumpedFirmware.hex:i 
```

Here is the grbl firmware project https://github.com/grbl
Pre-built binaries can be found there.
The latest (as of this writing) is version 0.9j

Use avrdude to flash grbl to 0.9j into s3 controller board:
```bash
avrdude -p m328p -P /dev/ttyACM0 -c arduino -D -Uflash:w:grbl_v0_9j_atmega328p_16mhz_115200.hex:a
```
Make sure you do these things to reset to the proper grbl default settings:
http://docs.carbide3d.com/article/38-shapeoko-3-default-grbl-settings
