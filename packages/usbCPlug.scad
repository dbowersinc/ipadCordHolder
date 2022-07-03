// Library: usbCPlug.scad
// Version: 1.0.0
// Author: David Bowers
// Copyright: 2022
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

// For print resolution
//$fa = 1;
//$fs = 0.4;

use <./Cord.scad>

cord_radius = 16;
plug_length = 20;

function get_cord_radius() = cord_radius;
function get_plug_length() = plug_length;

module usbCPlug(
    length = plug_length,
    width = 14,
    depth = 8,
    cord_rad = cord_radius
    )
    {
        centerline = (width - depth)/2;
        for (i = [1, -1]){
            translate([i * centerline, 0, 0]){
                cylinder(h = length, d = depth, center = true);
            }
        }
        cube([width - depth, depth, length], center = true);
        translate([0,-10,0])
        cube([width, 20, length], center = true);
        translate([cord_rad*2,0,5])
        cord(
            straight_section = 30,
            curve_radius = cord_rad,
            cord_thickness = 6,
            degree_of_curve = 180,
            tail_section = 20
            );
    }
    
    usbCPlug();
    