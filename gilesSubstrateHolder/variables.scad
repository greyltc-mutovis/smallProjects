// variables for a substrate holder for Giles
//written by grey@christoforo.net
//on 13 OCT 2015
//numbers in mm

substrate=28; //substrate len,wid
substrateBuffer=1; //some tolerance for slightlyBiggerSubstrates
aboveShelf=24; //height above shelf
belowShelf=24; //height below shelf

wallThickness=3; //top part wall thickness
boardBuffer=0.3; //tolerance around board
board=36; //board len, wid
shelf=3; //shelf size
window=23; //window len,wid
sideOpening=25; //width of opening in sides for clip/ribbon cable
clipDown=35; // clip slot offset from top

subsTol=1; // tolerance around substrate
capTol=0.2; //tolerance for cap fitting

wingWidth=10; //
wingLength=10; //
wingTol=1;

totalHeight=belowShelf+aboveShelf;
cubeInner=board+boardBuffer;
cubeOuter=cubeInner+wallThickness;