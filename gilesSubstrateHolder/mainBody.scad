//body geometery for a substrate holder for Giles
//written by grey@christoforo.net
//on 13 OCT 2015

include <variables.scad>

module edgeThing(){
    translate([0,-wingWidth/2,-wallThickness*2])
    cube([wingWidth,wingLength,wallThickness*2]);
}

union(){
    render() difference(){
        //start with chunk
        cube([cubeOuter,cubeOuter,totalHeight],center=true);
        //subtract region above shelf
        translate([0,0,belowShelf/2]) cube([cubeInner,cubeInner,aboveShelf],center=true);
        //subtract region below shelf
        translate([0,0,-aboveShelf/2]) cube([cubeInner-shelf*2,cubeInner-shelf*2,belowShelf],center=true);
        //subtract clip & ribbon cable space
        translate([0,0,-clipDown]){
            cube([cubeOuter+1,sideOpening,totalHeight],center=true);
            rotate([0,0,90])cube([cubeOuter+1,sideOpening,totalHeight],center=true);
        }
    }
    
    //edge things
    translate([cubeOuter/2,wingWidth+wingTol,totalHeight/2+wallThickness]) edgeThing();
    translate([cubeOuter/2,-wingWidth-wingTol,totalHeight/2+wallThickness]) edgeThing();
    mirror([1,0,0]) translate([cubeOuter/2,wingWidth+wingTol,totalHeight/2+wallThickness]) edgeThing();
    mirror([1,0,0]) translate([cubeOuter/2,-wingWidth-wingTol,totalHeight/2+wallThickness]) edgeThing();
    
}