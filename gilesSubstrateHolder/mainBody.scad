// body geometery for a substrate holder for Giles
// written by grey@christoforo.net
// on 13 OCT 2015

include <globals.scad>

union(){
    render() difference(){
        //start with big block to subtract from
        cube([cubeOuter,cubeOuter,totalHeight],center=true);
        //subtract region above shelf
        translate([0,0,belowShelf/2]) cube([cubeInner,cubeInner,aboveShelf],center=true);
        //subtract region below shelf
        translate([0,0,-aboveShelf/2]) cube([cubeInner-shelf*2,cubeInner-shelf*2,belowShelf],center=true);
        
        //small shelf
        cube([cubeInner-smallShelf,sideOpening,totalHeight],center=true);
        rotate([0,0,90]) cube([cubeInner-smallShelf,sideOpening,totalHeight],center=true);
        
        //subtract clip & ribbon cable space
        translate([0,0,-clipDown]){
            cube([cubeOuter,sideOpening,totalHeight],center=true);
            rotate([0,0,90])cube([cubeOuter,sideOpening,totalHeight],center=true);
        }
        //TODO: make holes for mounting PCB here
    }
    
    //edge things
    translate([cubeOuter/2,wingWidth+wingSpacing,totalHeight/2-wallThickness])rotate(a=[180,0,0])  edgeThing();
    translate([cubeOuter/2,-wingWidth-wingSpacing,totalHeight/2-wallThickness]) rotate(a=[180,0,0]) edgeThing();
    mirror([1,0,0]) translate([cubeOuter/2,wingWidth+wingSpacing,totalHeight/2-wallThickness]) rotate(a=[180,0,0]) edgeThing();
    mirror([1,0,0]) translate([cubeOuter/2,-wingWidth-wingSpacing,totalHeight/2-wallThickness]) rotate(a=[180,0,0]) edgeThing();
}