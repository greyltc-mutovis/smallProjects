// variables and global things for a single substrate holder
// to position a PCB with pogo-pins relative to a solar cell substrate
// for electrical characterization under illumination
// written by grey@christoforo.net
// on 13 OCT 2015
// numbers in mm
$fn = 49; // defines arc roughness

keyWidth = 5; // for orientation key between cap and body
keyHeight = 3; // for orientation key between cap and body

//variables for body
aboveShelf=7.5; //height above shelf
belowShelf=34; //height below shelf
wallThickness=3; //wall thickness above PCB shelf
boardBuffer=0.3; //tolerance around board
board=36; //PCB len, wid
outletDown=15; // cable outlet offset from shelf
mountingHoleOffset = 2.3; //distance between edge of PCB and center of hole
holeDiameter = 2.6; //PCB mounting hole diameter
holeDepth = 5; //PCB mounting hole depth
holeDiameterTol = 0.2; //draw the mounting holes this much smaller
legSquare = 7; // leg slize square dim
shelfWidth = 1.5; //width of small shelf (& additional wall thickness of bottom half wall)
bodyWingWidth = 5;

//variables for cap
capTol=0.2; //tolerance for cap fitting
window=22; //window len,wid
substrate=28; //substrate len,wid
subsTol=1; // tolerance extra room around substrate
substrateOffsetX=subsTol/2; //substrate offset from centerline
substrateOffsetY=subsTol/2; //substrate offset from centerline
capInsetHeight = 6;
capOverhang = 10;
tweezerSlotWidth = 5;
tweezerSlotIndent = 1;

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