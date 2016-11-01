$fn=49;
union(){
    linear_extrude(4.5) import("adapter-layer1.dxf");
    linear_extrude(0.5) import("adapter-layer2.dxf");
}