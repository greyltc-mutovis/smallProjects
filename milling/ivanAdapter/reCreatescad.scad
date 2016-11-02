//$fn=49;
difference(){
    linear_extrude(4.5) import("adapter-layer1.dxf");
    translate([0,0,0.5])linear_extrude(4) import("adapter-layer2.dxf");
}