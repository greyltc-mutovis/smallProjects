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

Here is the grbl firmware project https://github.com/gnea/grbl
Here's how to build the firmware:
```
git clone https://github.com/gnea/grbl.git
cd grbl
git checkout f51268e # the latest as of this writing
# reconfigure for shapeoko 3
sed -i 's,#define DEFAULTS_GENERIC,#define DEFAULTS_SHAPEOKO_3,g' grbl/config.h
make
# your new firmware is now the grbl.hex file
```
The latest (as of this writing) is version grbl_v1.1f.20170131

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
1. Edit DXF to contain a number of layers. Each layer
  - defines one single mono-height cutting surface.
  - contains only one closed loop.
  - is comprised of only arc and line segments.
1. Open bCNC
1. Import cutting plane defining DXF
1. Setup bit (especially tool diameter)
1. Setup material (especially feed rate and z step)
1 Setup stock (especially thickness)
1. Set up toolpaths which generate gcode
  1. Rotate things properly
  1. Set workpiece zero properly
  1. Re-order the loops to have an appropriate cutting order
  1. Select individual loops and generate pockets or profiles from each of them
    - insert tabs as needed into profiles
    - then generate cuts from the above loops and profiles taking care to set starting and finishing plane heights properly
1. Visualize gcode with linuxcnc or camotics
1. Send the gcode to cutter with bCNC or universal gcode sender

#### Proprietary (closed source workflow)

1. Generate STEP file in whatever
1. Open file in Fusion 360 (free license)
1. Generate toolpaths & gcode
1. Send g-code to cutter with carbide motion

#### Toolpath generaion with Fusion360

1. Import step file
1. Switch to CAM mode
1. Click Setup icon with folder and box
1. Define the stock dimensions
 - Add X mm offset the top of the part here such that the total stock Z matches the actual stock to be cut
 - Set stock side offset to 0 mm
1. Make a new roughing toolpath -- Click "3D" button then "pocket clearing"
1. In tool tab, pick the proper tool diameter and shape
 - Set all the tool's feedrates to 500 mm/min
 - Set the tool's plunge feedrate to 100 mm/min
 - Set the tool's coolant = disabled
1. In Geometry tab
 - Set machining boundary = selection and choose the outer most loop or ("wire")
 - Set tool containment =  Tool inside boundary
 - Set additional offset to -1x (tool diameter + roughing offset + 0.1mm) (maybe -1x(6.35+0.5+0.1)=-6.95mm)
1. In Passes tab
 - Use Morphed Spiral Machining
 - Maximum Roughing Stepdown = 2mm
 - Enable smoothing
1. In Passes tab
 - Retraction policy to minimum retraction
 - Ramp Type to Plunge
1. Click OK and the roughing toolpath will be generated (with 0.5mm offset)
1. Make a new finishing toolpath -- Right click on the roughing toolpath (Poket1 maybe) --> Create Derived Operation --> 3D milling --> Parallel
1. In Geometry tab
 - Set Additional offset to -1x (tool diameter + roughing offset + 0.01mm) (maybe -6.86mm)
1. Click OK and the finishing toolpath will be generated
1. Make a new finishing toolpath -- Right click on the path you just created (Poket1 maybe) --> Create Derived Operation --> 3D milling --> Contour
1. In Geometry tab
 - Set Additional offset to -1x (tool diameter + roughing offset + 0.01mm) (maybe -6.86mm)
1. In Passes tab
 - Set direction to conventional
 - Set maximum stepdown to 1mm
1. Click OK and the finishing toolpath will be generated
1. Select all the toolpaths and click simulate in the Actions toolbar.
 - Check for red parts of the green line at the bottom of the screen, those are detected collisions.
1. Export the .nc code by clicking post process in the Actions toolbar
 - Post process for generic Grbl


TODO: This method does not have holding tabs!
