deviceFudge=0.5;//mm, fudge factor to account for printing inaccuracy, shrinkage
PCBThickness=1.6; //mm
pinRecepticalTop=5.5;//mm above pcb that the pin receptical extends
pinsHeight=pinRecepticalTop+4.2+2;//mm above pcb, fully extended
maxSubstrateThickness=3;//mm
wallT=3;//mm, wall thickness
PCBShelfW=0.6;//mm, the pcb sits on this
belowPBC=1;//mm extension below PCB
crownFraction=0.55;//fraction of each side length to subtract to make extension corners

solidHeight=pinsHeight;//mm above pcb for solid wall
crownHeight=maxSubstrateThickness+0.5;//mm, corners extension above pin ends
totalHeight=belowPBC+PCBThickness+solidHeight+crownHeight;

module base ( xyDev ) {
    vDeviceDim=xyDev+deviceFudge;
    xyLen=vDeviceDim+wallT*2;
    difference(){
        cube([xyLen,xyLen,totalHeight],center = true);
        translate([0,0,belowPBC]) cube([vDeviceDim,vDeviceDim,totalHeight],center = true);
        cube([vDeviceDim-2*PCBShelfW,vDeviceDim-2*PCBShelfW,totalHeight+1],center = true);
        
        translate([0,xyLen/2,totalHeight/2+(crownHeight+1)/2-crownHeight]) cube([xyLen*crownFraction,xyLen,crownHeight+1],center = true);
        rotate([0,0,180]) translate([-xyLen*crownFraction/2,-xyLen/2,totalHeight/2-crownHeight]) rotate([0,90,0])  linear_extrude(height=xyLen*crownFraction) polygon([[0,0],[0,wallT],[(pinsHeight-pinRecepticalTop),wallT]]);
        
        rotate([0,0,90]) translate([0,xyLen/2,totalHeight/2+(crownHeight+1)/2-crownHeight]) cube([xyLen*crownFraction,xyLen,crownHeight+1],center = true);
        rotate([0,0,270]) translate([-xyLen*crownFraction/2,-xyLen/2,totalHeight/2-crownHeight]) rotate([0,90,0])  linear_extrude(height=xyLen*crownFraction) polygon([[0,0],[0,wallT],[(pinsHeight-pinRecepticalTop),wallT]]);
        
        rotate([0,0,180]) translate([0,xyLen/2,totalHeight/2+(crownHeight+1)/2-crownHeight]) cube([xyLen*crownFraction,xyLen,crownHeight+1],center = true);
        translate([-xyLen*crownFraction/2,-xyLen/2,totalHeight/2-crownHeight]) rotate([0,90,0])  linear_extrude(height=xyLen*crownFraction) polygon([[0,0],[0,wallT],[(pinsHeight-pinRecepticalTop),wallT]]);
        
        rotate([0,0,270]) translate([0,xyLen/2,totalHeight/2+(crownHeight+1)/2-crownHeight]) cube([xyLen*crownFraction,xyLen,crownHeight+1],center = true);
        rotate([0,0,90]) translate([-xyLen*crownFraction/2,-xyLen/2,totalHeight/2-crownHeight]) rotate([0,90,0])  linear_extrude(height=xyLen*crownFraction) polygon([[0,0],[0,wallT],[(pinsHeight-pinRecepticalTop),wallT]]);
    }
}
