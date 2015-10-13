//a substrate holder for Giles
//written by grey@christoforo.net
//on 13 OCT 2015
//numbers in mm
substrate=28; //substrate len,wid
substrateBuffer=1; //some tolerance for slightlyBiggerSubstrates
aboveShelf=23; //height above shelf
belowShelf=25; //height below shelf

wallThickness=3; //top part wall thickness
boardBuffer=1; //tolerance around board
board=36; //board len, wid
shelf=3; //shelf size
window=23; //window len,wid
tribase=25; //base length of triangle in sides
triheight=25; //height of triangle in sides
clipSlot=10; // width of slot for clip
clipDown=30; // clip slot offset from top

totalHeight=belowShelf+aboveShelf;
cubeInner=board+boardBuffer;
cubeOuter=cubeInner+wallThickness;

module tri(){
    polygon([[-tribase/2,0],[tribase/2,0],[0,triheight]]);
}

render() difference(){
    //start with chunk
    cube([cubeOuter,cubeOuter,totalHeight],center=true);
    //subtract region above shelf
    translate([0,0,belowShelf/2]) cube([cubeInner,cubeInner,aboveShelf],center=true);
    //subtract region below shelf
    translate([0,0,-aboveShelf/2]) cube([cubeInner-shelf,cubeInner-shelf,belowShelf],center=true);
    //subtract clip & ribbon cable space
    translate([0,0,-totalHeight/2-1]){
        rotate([90,0,0]) linear_extrude(cubeOuter+2,center=true) tri();
        rotate([90,0,90]) linear_extrude(cubeOuter+2,center=true) tri();
    }
}
