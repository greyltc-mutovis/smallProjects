// body geometery for a single substrate holder
// written by grey@christoforo.net
// on 13 OCT 2015

// modified by James Ball
// on 18 July 2017

include <globals_new.scad>

module leg(){
    translate([cubeOuter/2-legSquare,cubeOuter/2-legSquare,(-totalHeight)/2]){
        cube([legSquare,legSquare,belowShelf]);
    }
}

module PCBMountingHole(){
    localHoleDiameter = holeDiameter - holeDiameterTol;
    translate([board/2-mountingHoleOffset,board/2-mountingHoleOffset,totalHeight/2-holeDepth-aboveShelf]) cylinder(holeDepth,d=localHoleDiameter);
}

module mainBody(){
    difference(){
        union(){
            render() difference(){
                //start with big block to subtract from
                cube([cubeOuter,cubeOuter,totalHeight],center=true);
                //subtract region above shelf
                translate([0,0,belowShelf/2]) cube([cubeInner,cubeInner,aboveShelf],center=true);
                //subtract region below shelf
                translate([0,0,-aboveShelf/2]) cube([cubeInner-shelfWidth*2,cubeInner-shelfWidth*2,belowShelf],center=true);        
                //cable outlet spaces
//            translate([cubeOuter/2,0,belowShelf/2-aboveShelf/2-sideOpeningHeight/2-outletDown]) cube([cubeOuter,sideOpeningWidth,sideOpeningHeight],center=true);
//            rotate(a=[0,0,90]) translate([cubeOuter/2,0,belowShelf/2-aboveShelf/2-outletDown-sideOpeningHeight/2]) cube([cubeOuter,sideOpeningWidth,sideOpeningHeight],center=true);
            }
        
            // add in "legs"
            rotate(a=[0,0,0]) leg();
            rotate(a=[0,0,90]) leg();
            rotate(a=[0,0,180]) leg();
            rotate(a=[0,0,270]) leg();
        
            // add in wings
            translate([-cubeOuter/2,cubeInner/2,belowShelf/2+aboveShelf/2-wallThickness]) cube([cubeOuter,bodyWingWidth+wallThickness/2,wallThickness]);
            rotate(a=[0,0,180]) translate([-cubeOuter/2,cubeInner/2,belowShelf/2+aboveShelf/2-wallThickness]) cube([cubeOuter,bodyWingWidth+wallThickness/2,wallThickness]);
        
            // add the height spacer
            translate([-cubeOuter/2 - spacerThickness,-cubeOuter/2,-totalHeight/2]) cube([spacerThickness,cubeOuter,totalHeight]);
        }
        // drill PCB mounting holes
        rotate(a=[0,0,0]) PCBMountingHole();
        rotate(a=[0,0,90]) PCBMountingHole();
        rotate(a=[0,0,180]) PCBMountingHole();
        rotate(a=[0,0,270]) PCBMountingHole();
    
        // subtract alignment gap for photodiode holder
        translate([0,cubeOuter/2,totalHeight/2-(diodeHeight+wallThickness)/2]) cube([keyWidth,cubeOuter/2,diodeHeight+wallThickness],center=true);
    
        // subtract keyway
        translate([cubeOuter/2,0,totalHeight/2-keyHeight/2]) cube([cubeOuter/2,keyWidth,keyHeight],center=true);
    }
}
mainBody();

//create a 2d projection at z=0. Translate or rotate to get projection at different positions/orientations
//projection(cut=true) translate([0,0,-30]) rotate([0,0,0]) mainBody();
