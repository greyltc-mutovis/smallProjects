// cap geometery for a single substrate holder
// written by grey@christoforo.net
// on 13 OCT 2015

// modified by James Ball
// on 18 July 2017

include <globals_new.scad>

module cap(){
    difference(){
        union() {
            //top & window
            render() difference(){
                translate([spacerThickness/2, 0, 0]) cube([cubeOuter+capOverhang*2+spacerThickness,cubeOuter+capOverhang*2,wallThickness],center=true);
                cube([window,window,wallThickness],center=true);
            }
        
            //cap & substrate positioner
            translate([0, 0, -wallThickness/2-capInsetHeight/2])
            render() difference(){
                union(){
                    cube([cubeInner-capTol,cubeInner-capTol,capInsetHeight],center=true);
                    localKeyHeight = keyHeight-capTol;
                    localKeyWidth = keyWidth-capTol;
                    translate([-(cubeOuter+capOverhang*2)/2,-localKeyWidth/2,capInsetHeight/2-localKeyHeight]) cube([(cubeOuter+capOverhang*2)/2,localKeyWidth,localKeyHeight]);    // key
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
}
cap();

//create a 2d projection at z=0. Translate or rotate to get projection at different positions/orientations
//projection(cut=true) translate([0,0,3]) rotate([0,0,0]) cap();