// Library: ipadcharger.scad
// Version: 2.0.1
// Author: David Bowers
// Copyright: 2022
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

// ipadCharger(include_cord:bool);

// EXAMPLE USAGE:
// ipadCharger();
// ipadCharger(false); use without cord. 


include <MCAD/boxes.scad>

module charger_block(
    charger_square = 46, 
    charger_height = 29, 
    edge_radius = 4.5)
{
    roundedBox(
        size=[charger_square,charger_square,charger_height], 
        radius=edge_radius
    );
    translate(
        [-charger_square/2,-charger_square/2+6,0]
    )
    cube(
        [4,8,20],center=true
    );
}
// the tail and the start should be their own pieces
module cord(
    straight_section = 30,
    curve_radius = 20,
    cord_thickness = 6,
    degree_of_curve = 180,
    tail_section = 30
)
{
    translate([0, 0, abs(straight_section/2-tail_section/2)]){
        translate([0, -curve_radius/2, 0])
            cube(
                [cord_thickness, 
                curve_radius, 
                tail_section], 
                center=true
            );
        cylinder(
            h = tail_section, 
            d = cord_thickness, 
            center = true);
    }
    translate([-curve_radius,0,straight_section/2]){
        rotate([90,0,0]){
            rotate_extrude(angle=degree_of_curve){
                translate([curve_radius,0])
                    circle(d=cord_thickness);
                translate([curve_radius, curve_radius/2])
                    square([cord_thickness, curve_radius],                center = true);   
            }
        }
    }
    translate([-curve_radius*2, 0, 0]){
        translate([0, -curve_radius/2, 0])
        cube(
            [cord_thickness, 
            curve_radius, 
            straight_section], 
            center=true
            );
        cylinder(
        h = straight_section, 
        d = cord_thickness, 
        center = true
            );
    }
          
}
// cord();
// The plug is (-x, y) 2nd quadrant located
// depending on given type {ipad, mac_small, mac_large}
module plug(
    plug_length = 25,
    plug_width = 22,
    plug_thick = 8,
    cord_straight = 30,
    cord_curve = 20,
    cord_thickness = 6,
    cord_rotation = 180,
    cord_tail = 15,
    opposite = false
)
{
    cord_x = opposite ? cord_curve*2 : 0;
    roundedBox(
        size=[plug_thick,plug_width,plug_length],
        radius=plug_thick/2, 
        sidesonly=true
    );
    translate([0, -plug_width/2, 0])
    cube(
        [plug_thick,
        plug_width,
        plug_length],
        center=true);
    translate([cord_x, 0, abs(cord_straight-plug_length)/2])
        cord(
            cord_straight,
            cord_curve,
            cord_thickness,
            cord_rotation,
            cord_tail 
        );
}

 //plug(opposite=true);

module ipadCharger(
    w_plug = true,
    block = [ 46, 29, 4.5 ],
    plug = [ 25, 17, 9 ]
)
{
    charger_block(
        block[0],
        block[1],
        block[2]
    );
    if (w_plug){
        translate([ -8.5, block[0]/2+plug[0]/2, 0]){
            rotate([270, 0, 0])
                plug(
                    plug[0],
                    plug[1],
                    plug[2]
                );
        }
    } 
}

module MacLargeBlock_Prong(
    w_plug = true,
    block = [ 80, 29, 6 ],
    plug = [ 25, 17, 9 ],
    cord = [ 30, 32, -3]
) 
{
        charger_block(
        block[0],
        block[1],
        block[2]
    );
    difference() {
    if (w_plug){
        translate([ -19, block[0]/2+plug[0]/2, 0]){
            rotate([270, 0, 0])
                plug(
                    plug[0],
                    plug[1],
                    plug[2],
                    cord[0],
                    cord[1],
                    cord_tail=cord[2],
                    opposite=true
                );
        }
    }
    translate([40,73,15]){
        rotate([0,0,30])
        cube([30,30,40], center=true);
    } 
}
}

MacLargeBlock_Prong();

// ipadCharger();
// charger_block();