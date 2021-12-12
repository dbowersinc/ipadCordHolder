// Library: iPadCordHolder.scad
// Version: 1.0.0
// Author: David Bowers
// Copyright: 2022
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

// ipadCordHolder(); 
//   Made to export a 3D printable stl file from.abs

// EXAMPLE USAGE:
// ipadCordHolder();
//   export stl file and import it into your printer software. 

// Comment out these two lines if rendering is to slow.
$fa = 1;
$fs = 0.4;

use <./packages/iPadCharger_v201.scad>

oblongy = 70;
girthx = 80;
thickz = 17;
channelz = 22;
channelx = girthx/2;
channely = oblongy/2;

module theEgg(
    oblongy = 90,
    girthx = 70,
    thickz = 23,
)
{
    endos = [-oblongy/2, oblongy/2];
    for ( end = endos){
        translate([0, end, 0])
            cylinder(h=thickz, d=girthx, center=true);
    }
    cube([girthx, oblongy, thickz], center = true);
    
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
        oblongy, 
        girthx, 
        thickz
    );
    theChannel(
        channelz,
        channelx,
        channely
    );
    translate([0, -oblongy/3, thickz/4]){
        rotate([0, 0, -15])
        ipadCharger(true);
    }
    for (opps = [-1, 1]){
        translate([opps*girthx/4, oblongy/4, 0]){
            rotate([ 0, 0, 90])
                cube([15, 4, thickz+2], center = true);
        }
    }
}
