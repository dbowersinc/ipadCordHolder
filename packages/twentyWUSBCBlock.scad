// Library: twentyWUSBCBlock.scad
// Version: 1.0.0
// Author: David Bowers
// Copyright: 2022
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

// twenty_charger_block(length, width, height, edge_radius);

// EXAMPLE USAGE:
// twenty_charger_block();

include <MCAD/boxes.scad>

block_length = 41.5;
block_edge_rad = 8;

function get_block_length() = block_length;
function get_block_edge_rad() = block_edge_rad;

module prong(
    length = 19,
    width = 7,
    thickness = 2
    )
    {
        translate([-length/2,0,0])
        rotate([0,0,90])        
        cube([thickness, length, width], center = true);
    }

module twenty_charger_block(
    length = block_length, 
    width = 42.5,
    height = 27, 
    edge_radius = block_edge_rad)
{
    rotate([0,90,0])
    roundedBox(
        size=[ height, width, length],
        radius=edge_radius,
        sidesonly=true
    );
    for (z = [0 : 2]){
        for (i = [1, -1]){
        translate([-length/2, i*6.5, z*7])
        prong();
        }
    }

}

twenty_charger_block();
