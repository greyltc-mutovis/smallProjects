//body geometery for a substrate holder for Giles
//written by grey@christoforo.net
//on 13 OCT 2015

include <variables.scad>

//body
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
