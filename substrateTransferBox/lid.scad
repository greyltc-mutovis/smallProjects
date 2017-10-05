// Lid of sealed substrate chamber for transferring samples between gloveboxes
// without exposing them to air.

// by James Ball, 22-09-2017


// lid parameters
l = 264;
w = 66;
d = 5;

// o-ring parameters
oring_diam = 5.3;
oring_inner_l = 239;
oring_inner_w = 38;
oring_outer_l = oring_inner_l + 2 * oring_diam;
oring_outer_w = oring_inner_w + 2 * oring_diam;
oring_d = 2;
oring_corner_r = 12;

// screw parameters
screw_buffer = 4;
clearance_diameter = 4.5;

// drill parameters
drill_diameter = 5;

module rounded_cube(l, w, d, r){
    hull(){
        translate([r, r, 0])cylinder(h=d, r=r);
        translate([l - r, r, 0])cylinder(h=d, r=r);
        translate([r, w - r, 0])cylinder(h=d, r=r);
        translate([l - r, w - r, 0])cylinder(h=d, r=r);
    }
}

module screw_clearance(){
    cylinder(h=d, r=clearance_diameter/2);
}

module oring(){
    difference(){
        rounded_cube(oring_outer_l, oring_outer_w, oring_d, oring_corner_r);
        translate([(oring_outer_l - oring_inner_l)/2, (oring_outer_w - oring_inner_w)/2, 0])rounded_cube(oring_inner_l, oring_inner_w, oring_d, oring_corner_r - (oring_outer_l - oring_inner_l)/2);
    }  
}
module lid(){
    difference(){
        cube([l,w,d]);
        translate([(l - oring_outer_l)/2, (w - oring_outer_w)/2, d - oring_d])oring();
        translate([screw_buffer, screw_buffer, 0])screw_clearance();
        translate([screw_buffer, w - screw_buffer, 0])screw_clearance();
        translate([l - screw_buffer, screw_buffer, 0])screw_clearance();
        translate([l - screw_buffer, w - screw_buffer, 0])screw_clearance();
        translate([l/2, screw_buffer, 0])screw_clearance();
        translate([l/2, w - screw_buffer, 0])screw_clearance();
    }
}
lid();