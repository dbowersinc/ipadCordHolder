// Library: AppleCordHandler_TwentyW.scad
// Version: 2.0.1
// Author: David Bowers
// Copyright: 2022
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

// AppleCordHandler(); 
//   Made to export a 3D printable stl file from.abs

// EXAMPLE USAGE:
// AppleCordHandler();
//   export stl file and import it into your printer software. 


// Comment out these two lines if rendering is to slow.
$fa = 1;
$fs = 0.4;

use <./packages/twentyWCharger.scad>


pill_diameter = 48+17;
pill_straight = 110+17 - pill_diameter;
thickz = 20;
channelz = 17;
channelx = pill_diameter/2;
channely = pill_straight/2;

module theEgg(
    pill_straight = 90,
    pill_diameter = 70,
    thickz = 23,
)
{
    endos = [-pill_straight/2, pill_straight/2];
    for ( end = endos){
        translate([0, end, 0])
            cylinder(h=thickz, d=pill_diameter, center=true);
    }
    cube([pill_diameter, pill_straight, thickz], center = true);
    
}

module theChannel(
    cord_w = 12,
    widthx = 35,
    midsection = 45,
)
{
    rotationAngle = 180;
    for (thinkPositive = [-1, 1]){
        translate([0, thinkPositive*midsection, 0]){
            rotate_extrude(angle = thinkPositive*rotationAngle){
                translate([widthx, 0, 0])
                circle(d=cord_w);
            }
        }
        translate([thinkPositive*widthx, 0, 0]){
            rotate([90, 0, 0])
                cylinder(
                    h = midsection*2, 
                    d = cord_w, 
                    center = true
                );
        }
    }
    
}
block_edge = get_block_rad();

difference(){
    theEgg(
        pill_straight, 
        pill_diameter, 
        thickz
    );
    theChannel(
        channelz,
        channelx,
        channely
    );
        translate([-2, -pill_straight/5, block_edge/2.5])
        rotate([0, 0, 90])
        twentyWCharger();
    
    for (opps = [-1, 1]){
        translate([opps*42/2.5, pill_straight/3, 0]){
            rotate([ 0, 0, 90])
                cube([15, 4, thickz+2], center = true);
        }
    }
}
