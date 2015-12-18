//Encapsulation tool, Ivan Ramirez

//designed to be used with vacuum pen (will not work if glass scribed/laser engraved too deep)
//Steps: 
//  1) put gloves on, coat cavity sides in epoxy
//  2) drop cavity in encapsulation tool, glue up, with vac pen
//  3) drop sample in encapsuation tool with vac pen
//  4) press down for a few seconds, lift whole thing up, next

//user dimensions (in mm)
l_encaps = 24; //side of square including tol
h_encaps = 1.1; //full height, including cavity
h_en_margin = 0; //protrusion of cavity

l_sub = 28.5; //side of substrate inc margin
h_sub = 1.1; //height of glass
h_sub_margin = 0.2; //protrusion of substrate

t_wall = 2; // wall thicknss
t_base = 10; // bottom base thickness

//calculated quantities
H_smaller = h_encaps - h_en_margin; 
H_larger = h_sub - h_sub_margin;

H_tot = H_smaller + H_larger+t_base;
l_outer = t_wall + l_sub;

//translations
dx_sub = (l_outer-l_sub)/2;
trans_sub = [dx_sub,dx_sub, H_tot-H_larger];
dx_caps= (l_outer-l_encaps)/2;
trans_caps = [dx_caps,dx_caps, H_tot-H_larger-H_smaller];

render()
difference(){
    //start from solid block
    cube([l_outer, l_outer, H_tot]);
    //now make pocket for substrate
    translate(trans_sub)cube([l_sub, l_sub, H_larger]);
    //now make pocket for encaps glass
    translate(trans_caps)cube([l_encaps, l_encaps, H_smaller]);
}
