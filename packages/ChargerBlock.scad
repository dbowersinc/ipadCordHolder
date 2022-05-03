// Library: ChargerBlock.scad
// Version: 1.0.0
// Author: David Bowers
// Copyright: 2022
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

// charger_block(charger_sqaure, charger_height, edge_radius);

// EXAMPLE USAGE:
// charger_block();

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