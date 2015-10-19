//cap geometery for a substrate holder for Giles
//written by grey@christoforo.net
//on 13 OCT 2015

include <variables.scad>

//edge thing, Zmax=0, y= centered, mirrorable across @x=0 plane
module edgeThing(){
    translate([0,-wingWidth/2,-wallThickness*2])
    cube([wingWidth,wingLength,wallThickness*2]);
}

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