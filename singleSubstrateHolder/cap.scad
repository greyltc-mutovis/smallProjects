// cap geometery for a single substrate holder
// written by grey@christoforo.net
// on 13 OCT 2015

include <globals.scad>

difference(){
    union() {
        //top & window
        render() difference(){
            cube([cubeOuter+capOverhang*2,cubeOuter+capOverhang*2,wallThickness],center=true);
            cube([window,window,wallThickness],center=true);
        }
        
        //cap & substrate positioner
        translate([0, 0, -wallThickness/2-capInsetHeight/2])
        render() difference(){
            union(){
                cube([cubeInner-capTol,cubeInner-capTol,capInsetHeight],center=true);
                localKeyHeight = keyHeight-capTol;
                localKeyWidth = keyWidth-capTol;
                translate([-(cubeOuter+capOverhang*2)/2,-localKeyWidth/2,capInsetHeight/2-localKeyHeight]) cube([(cubeOuter+capOverhang*2)/2,localKeyWidth,localKeyHeight]); // key
            }
            translate([substrateOffsetX,substrateOffsetY,0]) union(){
                cube([substrate+subsTol,substrate+subsTol,capInsetHeight],center=true);
                translate([-(substrate+subsTol)/2,-(substrate+subsTol)/2,-capInsetHeight/2]) cylinder(capInsetHeight,d=4); //allignment corner indicator
            }
        }
    }
    //tweezer slots
    translate([0,0,tweezerSlotIndent/2-wallThickness/2-capInsetHeight/2]) {
        cube([tweezerSlotWidth,cubeInner-capTol,capInsetHeight+tweezerSlotIndent],center=true);
        rotate(a=[0,0,-90]) translate([0,(cubeInner-capTol)/4,0]) cube([tweezerSlotWidth,(cubeInner-capTol)/2,capInsetHeight+tweezerSlotIndent],center=true);
        }
}
