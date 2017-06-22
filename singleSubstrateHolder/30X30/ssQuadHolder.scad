//pcb
*translate([-15,-15,0]) cube([30,30,1.6]);

lipper=28;
longWay=40;
otherWay=32;

height=3.4;

union(){
translate([0,0,-1.6]){
    union(){
    difference(){
        translate([-longWay/2,-15,0]) cube([longWay,30,1.6]);
        translate([-31/2,-11,0]) cube([31,22,1.6]);
        translate([-lipper/2,-15,0]) cube([lipper,30,1.6]);
    }
    difference(){
        translate([-longWay/2,-otherWay/2,0]) cube([longWay,otherWay,1.6]);
        translate([-longWay/2,-15,0]) cube([longWay,30,1.6]);
    }
    difference(){
        translate([-longWay/2,-otherWay/2,0]) cube([longWay,otherWay,height]);
        translate([-15,-15,0]) cube([30,30,height]);
    }
}
}
}