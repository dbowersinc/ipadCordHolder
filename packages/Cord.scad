// Library: Cord.scad
// Version: 1.0.0
// Author: David Bowers
// Copyright: 2022
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

// cord(
//  straight_section,
//  curve_radius,
//  cord_thickness,
//  degree_of_curve,
//  tail_section
// );

// EXAMPLE USAGE:
// cord();

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
        translate([0, -15, 0])
            cube(
                [cord_thickness, 
                30, 
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
                translate([curve_radius, 15])
                    square([cord_thickness, 30],                center = true);   
            }
        }
    }
    translate([-curve_radius*2, 0, 0]){
        translate([0, -15, 0])
        cube(
            [cord_thickness, 
            30, 
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

cord();