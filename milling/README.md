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
1. release capacitor button (only once avrdude is good and done with its thing)
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

Then make sure homing is enabled because we have the switches. Here's the grbl command to run for that:
```
$22=1
```
check all settings with grbl command:
```
$$
```

Changes needed under settings in carbide connect:
```
1005 Shapeoko Has Homing: true
1006 Shapeoko Table X: 850
1007 Shapeoko Table Y: 430
```

#### Fully open source workflow (work in progress)

1. Generate STEP file in whatever
1. Open file in FreeCAD, part workbench
1. Create as many Z sections as need to define everything (with section tool in tool bar)
1. Switch to Draft workbench
1. Select everything and choose "Downgrade" toolbar item (blue arrow pointing down). This is the same as AUTOCAD's explode. Everything becomes edges.
1. Select edges and choose File --> Export... --> Auto Desk DXF
1. Open DXF file in bCNC
1. Set up toolpaths... to generate gcode
1. visualize gcode with linuxcnc
1. Send the gcode to cutter with bCNC or universal gcode sender

#### Proprietary (closed source workflow)

1. Generate STEP file in whatever
1. Open file in Fusion 360 (free license)
1. Generate toolpaths & gcode
1. Send g-code to cutter with carbide motion
