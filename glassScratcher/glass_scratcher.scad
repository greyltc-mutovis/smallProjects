glass_thickness = 2.2 + 0.1;


glass_dim = 30;
glass_fudge = 0.2;
pocket_dim = glass_dim + glass_fudge;

extraXY = 30;

x = glass_dim + extraXY;
y = glass_dim + extraXY;
z = 5;

slot_x_position = 15;

slot_depth = z - glass_thickness;

slot_width = 4;



difference(){
    cube([x,y,z]);
    
    // first slot
    translate([slot_x_position,0,glass_thickness]) cube([slot_width,y,slot_depth]);
    
    // middle slot
    translate([x/2-slot_width/2,0,glass_thickness]) cube([slot_width,y,slot_depth]);
    
    // third slot
    translate([x-slot_x_position-slot_width,0,glass_thickness]) cube([slot_width,y,slot_depth]);
    
    // glass pocket
    translate([(x-pocket_dim)/2,(y-pocket_dim)/2,0]) cube([pocket_dim,pocket_dim,glass_thickness]);
    
}