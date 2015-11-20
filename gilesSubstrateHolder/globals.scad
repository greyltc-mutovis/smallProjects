// variables and global things for a small rig for Giles
// to position a PCB with pogo-pins relative to a solar cell substrate
// for electrical characterization under illumination
// written by grey@christoforo.net
// on 13 OCT 2015
// numbers in mm

//variables for body
aboveShelf=24; //height above shelf
belowShelf=24; //height below shelf
wallThickness=3; //wall thickness above PCB shelf
boardBuffer=0.3; //tolerance around board
board=36; //PCB len, wid
sideOpening=25; //width of opening in sides for ribbon cable
clipDown=35; // clip slot offset from top
smallShelf=3; // width of small shelf (& additional wall thickness of bottom half)

//variables for cap
capTol=0.2; //tolerance for cap fitting
window=23; //window len,wid
substrate=28; //substrate len,wid
subsTol=2; // tolerance around substrate
substrateOffsetX=1; //substrate offset
substrateOffsetY=1; //substrate offset

wingWidth=10; //
wingLength=10; //
wingSpacing=3; // spacing between edge things

totalHeight=belowShelf+aboveShelf;
cubeInner=board+boardBuffer;
cubeOuter=cubeInner+wallThickness;
shelf=cubeInner/2-sideOpening/2; //shelf size

//edge thing, Zmax=0, y=centered, mirrorable across @x=0 plane
module edgeThing(){
    translate([0,-wingWidth/2,-wallThickness*2])
    difference(){
        cube([wingWidth,wingLength,wallThickness*2]);
        cube([capTol,wingLength,wallThickness]); //cutout for cap tolerace
    }
}