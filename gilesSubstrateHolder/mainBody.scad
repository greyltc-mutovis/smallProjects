//a substrate holder for Giles
//units in mm
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
render() difference(){
    //start with chunk
    cube([cubeOuter,cubeOuter,totalHeight],center=true);
    //subtract region above shelf
    translate([0,0,belowShelf/2]) cube([cubeInner,cubeInner,aboveShelf],center=true);
    //subtract region below shelf
    translate([0,0,-aboveShelf/2]) cube([cubeInner-shelf,cubeInner-shelf,belowShelf],center=true);
    //subtract clip & ribbon cable space
    translate([0,cubeOuter/2+1,-totalHeight/2-1]) rotate([90,0,0]) linear_extrude(cubeOuter+2) polygon([[-tribase/2,0],[tribase/2,0],[0,triheight]]);
    rotate([0,0,90]) translate([0,cubeOuter/2+1,-totalHeight/2-1]) rotate([90,0,0]) linear_extrude(cubeOuter+2) polygon([[-tribase/2,0],[tribase/2,0],[0,triheight]]);
    //render() difference(){
        //translate([0,0,-clipDown]) cube([cubeOuter,sideOpening,totalHeight],center=true);
        
        //#translate([0,0,-(totalHeight/2)+sideOpening/4]) rotate([0,-90,0]) cylinder(h=totalHeight,d=sideOpening,$fn=3,center=true);
        
        //#translate([0,0,(totalHeight-clipDown)/2]) rotate([-45,0,0]) translate([0,0,-clipDown]) cube([cubeOuter,sideOpening,totalHeight],center=true);
    //}
}
