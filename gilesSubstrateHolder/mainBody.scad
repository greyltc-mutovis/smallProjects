//a substrate holder for Giles
//units in mm
substrate=28; //substrate len,wid
substrateBuffer=1; //some tolerance for slightlyBiggerSubstrates
aboveShelf=23; //height above shelf
belowShelf=20; //height below shelf

wallThickness=3; //top part wall thickness
boardBuffer=1; //tolerance around board
board=36; //board len, wid
shelf=3; //shelf size
window=23; //window len,wid
sideOpening=25; //opening width for ribbon cable
clipSlot=10; // width of slot for clip
clipDown=30; // clip slot offset from top

totalHeight=belowShelf+aboveShelf;
cubeInner=board+boardBuffer;
cubeOuter=cubeInner+wallThickness;
render() difference(){
    cube([cubeOuter,cubeOuter,totalHeight],center=true);
    translate([0,0,belowShelf/2]) cube([cubeInner,cubeInner,aboveShelf],center=true);
    translate([0,0,-aboveShelf/2]) cube([cubeInner-shelf,cubeInner-shelf,belowShelf],center=true);
    translate([cubeInner/2,0,0]) cube([cubeInner,sideOpening,totalHeight],center=true);
    translate([-cubeInner/2,0,-clipDown]) cube([cubeInner,clipSlot,totalHeight],center=true);
}
