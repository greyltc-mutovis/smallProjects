//a substrate holder for Giles
//written by grey@christoforo.net
//on 13 OCT 2015
//numbers in mm
substrate=28; //substrate len,wid
substrateBuffer=1; //some tolerance for slightlyBiggerSubstrates
aboveShelf=24; //height above shelf
belowShelf=24; //height below shelf

wallThickness=3; //top part wall thickness
boardBuffer=1; //tolerance around board
board=36; //board len, wid
shelf=3; //shelf size
window=23; //window len,wid
sideOpening=25; //base length of triangle in sides
clipDown=35; // clip slot offset from top

totalHeight=belowShelf+aboveShelf;
cubeInner=board+boardBuffer;
cubeOuter=cubeInner+wallThickness;

render() difference(){
    //start with chunk
    cube([cubeOuter,cubeOuter,totalHeight],center=true);
    //subtract region above shelf
    translate([0,0,belowShelf/2]) cube([cubeInner,cubeInner,aboveShelf],center=true);
    //subtract region below shelf
    translate([0,0,-aboveShelf/2]) cube([cubeInner-shelf,cubeInner-shelf,belowShelf],center=true);
    //subtract clip & ribbon cable space
    translate([0,0,-clipDown]){
        cube([cubeOuter+1,sideOpening,totalHeight],center=true);
        rotate([0,0,90])cube([cubeOuter+1,sideOpening,totalHeight],center=true);
    }
}
