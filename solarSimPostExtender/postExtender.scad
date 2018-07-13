extra_height = 2.5; //mm
post_diameter = 6; //mm
post_spacing = 24.5; //mm
new_post_height = 5; //mm
block_width = 10;
block_length = 40;
block_height = 5;

$fn = 50;

difference(){
union(){
translate([0.25*block_width,0,block_height/2]) cube([block_width,block_length,block_height],center=true);
translate([0,post_spacing/2,block_height]) cylinder(new_post_height,d=post_diameter);
translate([0,-post_spacing/2,block_height]) cylinder(new_post_height,d=post_diameter);
}
translate([0,post_spacing/2,block_height-extra_height-new_post_height]) cylinder(new_post_height,d=post_diameter);
translate([0,-post_spacing/2,block_height-extra_height-new_post_height]) cylinder(new_post_height,d=post_diameter);
}