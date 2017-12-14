include <meta.scad>;

$fn=50;
deviceDim=28; //mm, x,y dimension of substrate, pcb
//deviceDim=30; //mm, x,y dimension of substrate, pcb
capFit=0.4; //mm, trace a circle of this radius around the crown pieces to define the cap cutouts
capX = 39;//mm
capY = 60;//mm

windowDim = deviceDim-4.5*2;
capT = 5;

difference(){
    linear_extrude(height=capT){
        difference(){
            square([capX,capY], center=true);
            minkowski(){
              projection(cut = true) translate([0,0,-totalHeight/2+1]) base(deviceDim);
              circle(capFit,center=true);
            }
            square([windowDim,windowDim], center=true);
        }
    }
    
    linear_extrude(height=capT,scale=windowDim/deviceDim){
        square([deviceDim,deviceDim], center=true);
    }
}