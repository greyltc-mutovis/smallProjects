// Base of sealed substrate chamber for transferring samples between gloveboxes
// without exposing them to air.

// by James Ball, 22-09-2017


// base parameters
l = 264;
w = 66;
d = 6;

// substrate aperature parameters
substrate_l = 30;
substrate_w = 30;
substrate_d = 3;
substrate_tol = 1;
substrate_spacing = 2;
number_of_substrates = 7;
substrates_total_l = (substrate_l + substrate_tol + substrate_spacing) * number_of_substrates - substrate_spacing;
substrates_total_w = substrate_w + substrate_tol;

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
tap_diameter = 3.4;

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

module substrates(){
    union(){
        for (x = [0 : 1 : number_of_substrates - 1])
            translate([x * (substrate_l + substrate_tol + substrate_spacing), 0, 0])
                cube([substrate_l + substrate_tol, substrate_w + substrate_tol, substrate_d]);
        translate([-drill_diameter/2, 0, 0])rounded_cube(substrates_total_l + drill_diameter, drill_diameter, substrate_d, drill_diameter/2);
        translate([-drill_diameter/2, substrate_w + substrate_tol - drill_diameter, 0])rounded_cube(substrates_total_l + drill_diameter, drill_diameter, substrate_d, drill_diameter/2);
    }
}

module screw_tap(){
    cylinder(h=d, r=tap_diameter/2);
}

module oring(){
    difference(){
        rounded_cube(oring_outer_l, oring_outer_w, oring_d, oring_corner_r);
        translate([(oring_outer_l - oring_inner_l)/2, (oring_outer_w - oring_inner_w)/2, 0])rounded_cube(oring_inner_l, oring_inner_w, oring_d, oring_corner_r - (oring_outer_l - oring_inner_l)/2);
    }  
}
module base(){
    difference(){
        cube([l,w,d]);
        translate([(l - oring_outer_l)/2, (w - oring_outer_w)/2, d - oring_d])oring();
        translate([(l - substrates_total_l)/2, (w - substrates_total_w)/2, d - substrate_d])substrates();
        translate([screw_buffer, screw_buffer, 0])screw_tap();
        translate([screw_buffer, w - screw_buffer, 0])screw_tap();
        translate([l - screw_buffer, screw_buffer, 0])screw_tap();
        translate([l - screw_buffer, w - screw_buffer, 0])screw_tap();
        translate([l/2, screw_buffer, 0])screw_tap();
        translate([l/2, w - screw_buffer, 0])screw_tap();
    }
}
base();

// projection(cut=true) translate([0,0,-d]) base();
// projection(cut=false) translate([0,-50,0]) rotate([90, 0, 0]) base();