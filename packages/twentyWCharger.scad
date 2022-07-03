// Library: twentyWCharger.scad
// Version: 1.0.0
// Author: David Bowers
// Copyright: 2022
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

use <./usbCPlug.scad>;
use <./twentyWUSBCBlock.scad>;

cord_radius = get_cord_radius();
plug_length = get_plug_length();
block_length = get_block_length();
function get_block_rad() = get_block_edge_rad();

module twentyWCharger(
    p_length = plug_length,
    c_radius = cord_radius,
    b_length = block_length
){
    translate([(p_length+b_length)/2,0,0])
    rotate([90,180,90])
    usbCPlug();
    twenty_charger_block();
}

twentyWCharger();