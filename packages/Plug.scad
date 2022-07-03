// Library: Plug.scad
// Version: 1.0.0
// Author: David Bowers
// Copyright: 2022
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

include <MCAD/boxes.scad>
use <./Cord.scad>

function cordStartLength(straight, diameter, rotation, tail) =
    let(
        degree = rotation / 360,
        circum_length = diameter * PI * degree
        )
       circum_length + straight + tail;

cord_de_straight = 30;
cord_de_curve = 20;
cord_de_thickness = 6;
cord_de_rotation = 180;
cord_de_tail = 15;

function getDefaultCordStartLen() =
    cordStartLength(cord_de_straight, cord_de_curve*2, cord_de_rotation, cord_de_tail);
    
// cord();
// The plug is (-x, y) 2nd quadrant located
// depending on given type {ipad, mac_small, mac_large}
module plug(
    plug_length = 25,
    plug_width = 22,
    plug_thick = 8,
    cord_straight = cord_de_straight,
    cord_curve = cord_de_curve,
    cord_thickness = cord_de_thickness,
    cord_rotation = cord_de_rotation,
    cord_tail = cord_de_tail,
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

plug();