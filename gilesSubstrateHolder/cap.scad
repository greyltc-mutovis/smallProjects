// cap geometery for a substrate holder for Giles
// written by grey@christoforo.net
// on 13 OCT 2015

include <globals.scad>

union() {
    //edge things
    translate([cubeOuter/2,0,wallThickness/2]) edgeThing();
    mirror([1,0,0]) translate([cubeOuter/2,0,wallThickness/2]) edgeThing();
    
    //top & window
    render() difference(){
        cube([cubeOuter,cubeOuter,wallThickness],center=true);
        cube([window,window,wallThickness],center=true);
    }
    
    //cap & substrate positioner
    translate([0, 0, -wallThickness])
    render() difference(){
        cube([cubeInner-capTol,cubeInner-capTol,wallThickness],center=true);
        cube([substrate+subsTol,substrate+subsTol,wallThickness],center=true);
    }
}