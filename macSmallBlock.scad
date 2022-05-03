// Library: macSmallBlock.scad
// Version: 1.0.0
// Author: David Bowers
// Copyright: 2022
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

// MacBlockProngCordHolder(); 
//   Made to export a 3D printable stl file from.abs

// EXAMPLE USAGE:
// MacBlockProngCordHolder();
//   export stl file and import it into your printer software. 

// Comment out these two lines if preview rendering is to slow.
// UnComment before render for stl to get a good print.
$fa = 1;
$fs = 0.4;

// ToDo: Add cord length function. 
//  The pill shape is adjusted to make a perfect wrap
//  for a given cord length and there is an end storage
//  so the tip is not all willy nilly out there in the 
//  world... That only leads to problems. 

use <./packages/iPadCharger_v201.scad>

// ToDo: Sizes should be calculated based on the block that
//       is pluged in and the cord length.

oblongy = 60;
girthx = 72;
thickz = 20;
channelz = 17;
channelx = girthx/2;
channely = oblongy/2;
rotation = -4;
// calc the end of the cord
cord_length = 1970.5;
start_section = 160;
slop_reduce = cord_length*1;
tot_cord_length = slop_reduce - start_section;
in_dia = girthx-channelz/2;

function calcCordEnd(cord_len, l, d) =
    let(rev_dist = d*PI + l*2)
    echo(rev_dist)
    cord_len % rev_dist;
    
echo(calcCordEnd(tot_cord_length, oblongy, in_dia));
echo(girthx*PI);
    

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
    translate([0, -oblongy/3.9, thickz/4.5]){
        rotate([0, 0, -rotation])
        MacSmallBlock_Prong(true);
    }
    for (opps = [-1, 1]){
        translate([opps*girthx/3, oblongy/2, 0]){
            rotate([ 0, 0, 90])
                cube([15, 4, thickz+2], center = true);
        }
    }
}
