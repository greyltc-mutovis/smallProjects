deviceDim=30+0.5; //mm
PCBThickness=1.6; //mm
//pinHeight=12;//fully extended, mm above pcb
pinHeight=3;//fully extended, mm above pcb
earsHeight=3;//mm, corners extend above pins
wallT=3;//mm, wall thickness
PCBShelfW=0.75;//mm, the pcb sits on this
belowPBC=1;//mm extension below PCB

difference(){
    cube([deviceDim+wallT*2,deviceDim+wallT*2,belowPBC+PCBThickness+pinHeight],center = true);
    translate([0,0,belowPBC]) cube([deviceDim,deviceDim,belowPBC+PCBThickness+pinHeight],center = true);
    cube([deviceDim-2*PCBShelfW,deviceDim-2*PCBShelfW,belowPBC+PCBThickness+pinHeight+1],center = true);
}