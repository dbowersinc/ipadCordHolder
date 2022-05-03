// Library: ipadcharger.scad
// Version: 2.0.3
// Author: David Bowers
// Copyright: 2022
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

// ipadCharger(include_cord:bool);

// EXAMPLE USAGE:
// ipadCharger();
// ipadCharger(false); use without cord. 

// Version Notes: 
//    Change the iPad block plug to opposite.

// TODO: The cord tail diameter should be relative to the size of the block.
// TODO: Version should be entered in from package release. 


include <MCAD/boxes.scad>

use <./ChargerBlock.scad>
use <./Plug.scad>
//use <./BodySizer.scad>

include_plug = true;
charger_square = 46; 
charger_height = 29; 
edge_radius = 4.5;
plug_length = 25;
plug_width = 17;
plug_thick = 9;
opposite = false;
cord_start_length = getDefaultCordStartLen();

function getCordStartLength() = cord_start_length;
function getChargerSquare() = charger_square;
// echo(cord_start_length);

module ipadCharger(
    w_plug = include_plug,
    block = [ 
        charger_square,
        charger_height, 
        edge_radius 
        ],
    plug = [ 
        plug_length, 
        plug_width, 
        plug_thick, 
        true 
        ]
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
                    plug[2],
                    opposite=plug[3]
                );
        }
    } 
}

ipadCharger();
