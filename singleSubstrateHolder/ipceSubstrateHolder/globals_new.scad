// variables and global things for a single substrate holder
// to position a PCB with pogo-pins relative to a solar cell substrate
// for electrical characterization under illumination
// written by grey@christoforo.net
// on 13 OCT 2015
// numbers in mm

// modified by James Ball
// on 18 July 2017

$fn = 49; // defines arc roughness

keyWidth = 5; // for orientation key between cap and body
keyHeight = 3; // for orientation key between cap and body

//variables for optical alignment
opticAxisHeight=41; //height of optic axis above stage base
pixelHeight=19; //height of pixels from substrate edge
focusFromUpper=5.6; //gap from inside of stage upper lip to focal plane

//variables for the stage
stageLowerWidth=43.8; //width of the lower gap in the stage
stageUpperWidth=67.3; //width of the upper gap in the stage
stageLowerHeight=8.1; //height of lower lip above stage base
stageUpperHeight=16.3; //height of upper lip above stage base

//variables for reference photodiode
diodeSocketDiam=11; //diameter of socket for reference photodiode
diodeHeight=4; //height of the diode photodiode
diodeGap=5; //gap between the two photodiodes
diodeLegDiam=2; //diameter of hole for photodiode leg
diodeLegGap=5; //centre-centre spacing for photodiode legs

//variables for cap
capTol=0.2; //tolerance for cap fitting
window=22; //window len,wid
substrate=28; //substrate len,wid
subsTol=1; // tolerance extra room around substrate
substrateOffsetX=subsTol/2; //substrate offset from centerline
substrateOffsetY=subsTol/2; //substrate offset from centerline
capInsetHeight = 6;
capOverhang = 0;
tweezerSlotWidth = 5;
tweezerSlotIndent = 1;

//variables for body
wallThickness=3; //wall thickness above PCB shelf
aboveShelf=24; //height above shelf
belowShelf=stageUpperWidth-aboveShelf-focusFromUpper; //height below shelf to make total height with cap fit on upper part of stage
boardBuffer=0.3; //tolerance around board
board=36; //PCB len, wid
outletDown=15; // cable outlet offset from shelf
mountingHoleOffset = 2.3; //distance between edge of PCB and center of hole
holeDiameter = 2.6; //PCB mounting hole diameter
holeDepth = 5; //PCB mounting hole depth
holeDiameterTol = 0.2; //draw the mounting holes this much smaller
legSquare = 7; // leg slize square dim
shelfWidth = 1.5; //width of small shelf (& additional wall thickness of bottom half wall)
bodyWingWidth = 0;

//variables for height spacer
spacerThickness=opticAxisHeight-(wallThickness+wallThickness+pixelHeight)-stageLowerHeight;

//other variables
PCBThickness = 1.5;

// design checks
//assert(aboveShelf>(capInsetHeight+PCBThickness,'ERROR: Object overlap detected.') //assert doesn't exist (yet!)

// calculated body vars
totalHeight=belowShelf+aboveShelf;
cubeInner=board+boardBuffer;
cubeOuter=cubeInner+wallThickness;

sideOpeningWidth=cubeOuter-2*legSquare; //width of opening in side for wire exit
sideOpeningHeight=10; //height of opening in side for wire exit


//edge thing, Zmax=0, y=centered, mirrorable across @x=0 plane
module edgeThing(){
    translate([0,-wingWidth/2,-wallThickness*2])
    difference(){
        cube([wingWidth,wingLength,wallThickness*2]);
        cube([capTol,wingLength,wallThickness]); //cutout for cap tolerace
    }
}