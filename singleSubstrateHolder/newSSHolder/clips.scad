include <meta.scad>;

$fn=50;
//deviceDim=28; //mm, x,y dimension of substrate, pcb
deviceDim=30; //mm, x,y dimension of substrate, pcb
capFit=0.4; //mm, trace a circle of this radius around the crown pieces to define the cap cutouts
//capX = 39;//mm
//capY = 60;//mm

vDeviceDim=deviceDim+deviceFudge;
xyLen=vDeviceDim+wallT*2;

capX = xyLen;
capY = xyLen;

windowDim = deviceDim-4*2;
capT = 5;

clipLength=15;
clipThickness=3;

fitFudge = 0;

rotate([-90,0,0])
difference(){
    cube([totalHeight-crownHeight+capT+2*clipThickness,clipThickness+wallT,clipLength],center=true);
    translate([0,-clipThickness,0]) cube([totalHeight-crownHeight+capT+fitFudge,clipThickness+wallT,clipLength],center=true);
}