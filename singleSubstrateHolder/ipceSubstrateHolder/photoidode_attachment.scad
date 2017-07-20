// photodiode attachment to the body of a single substrate holder
// written by James Ball
// on 18 July 2017

include <globals_new.scad>

module diodeSocketWithLegs(){
    union(){
        // diode hole
        translate([0, 0, (diodeHeight+wallThickness)/2 - diodeHeight/2]) cylinder(diodeHeight, d=diodeSocketDiam, center=true);
        
        // diode leg hole 1
        translate([0,diodeLegGap/2,-(diodeHeight+wallThickness)/2 + wallThickness/2]) cylinder(wallThickness, d=diodeLegDiam, center=true);
        
        // diode leg hole 1
        translate([0,-diodeLegGap/2,-(diodeHeight+wallThickness)/2 + wallThickness/2]) cylinder(wallThickness, d=diodeLegDiam, center=true);
        }
    }
module photodiodeAttachment(){
    union(){
        difference(){
            // body of the attachment
            cube([diodeSocketDiam*3, cubeOuter+spacerThickness, diodeHeight+wallThickness],     center=true);
    
            // photodiode socket 1
            translate([-diodeSocketDiam / 2 - diodeGap / 2, -(cubeOuter+spacerThickness)/2 + (opticAxisHeight-stageLowerHeight), 0]) diodeSocketWithLegs();
    
            // photodidoe socket 2
            translate([diodeSocketDiam / 2 + diodeGap / 2, -(cubeOuter+spacerThickness)/2 + (opticAxisHeight-stageLowerHeight), 0]) diodeSocketWithLegs();
        }

            // add alignment notch
            localKeyWidth = keyWidth-capTol;
            translate([(diodeSocketDiam*3+wallThickness/2)/2, (spacerThickness)/2, 0]) cube([wallThickness/2, localKeyWidth, diodeHeight+wallThickness],center=true);
    }
}
photodiodeAttachment();

//create a 2d projection at z=0. Translate or rotate to get projection at different positions/orientations
//projection(cut=true) translate([0,0,0]) rotate([0,0,0]) photodiodeAttachment();