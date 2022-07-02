// Library: iPadCordHolder.scad
// Version: 2.0.1
// Author: David Bowers
// Copyright: 2022
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

// ipadCordHolder(); 
//   Made to export a 3D printable stl file from.abs

// EXAMPLE USAGE:
// ipadCordHolder();
//   export stl file and import it into your printer software. 


// TODO:
//
// 1.   The minimum diameter is the charger width + 2.
// 2.   The bare cord into the plug diameter is a function
//      of the pill diameter. 
//

// Comment out these two lines if rendering is to slow.
$fa = 1;
$fs = 0.4;

use <./packages/iPadCharger_v203.scad>
use <./packages/BodySizer.scad>

total_cord_length = 72 * 25.4; // 72 in (1 in = 25.4 mm)
cord_start = getCordStartLength(); 

echo(cord_start);
cord_tail = 36; 
cord_segments = 5;
straight_ratio = .40;
diameter_ratio = 1 - straight_ratio; 

pill_straight = getStraight( 
                    total_cord_length, 
                    cord_start, 
                    cord_tail, 
                    cord_segments, 
                    straight_ratio
                    );
pill_diameter = getDiameter(
                    total_cord_length, 
                    cord_start,
                    cord_tail, 
                    cord_segments, 
                    diameter_ratio
                    );
echo(pill_diameter, pill_straight);
thickz = 20;
channelz = 17;
channelx = pill_diameter/2;
channely = pill_straight/2;
charger_square = getChargerSquare();

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
    translate([0, -pill_straight/3, thickz/4.6]){
        //rotate([0, 0, 0])
        ipadCharger(true);
    }
    for (opps = [-1, 1]){
        translate([opps*charger_square/2.5, pill_straight/4, 0]){
            rotate([ 0, 0, 90])
                cube([15, 4, thickz+2], center = true);
        }
    }
}
