// Library: BodySizer.scad
// Version: 1.0.0
// Author: David Bowers
// Copyright: 2022
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

// Usage:

// Based on a ratio passed
// Complete Length
function wrapLength(cord_length, start, tail) =
    cord_length - (start + tail);
    
function segmentLength(segment_count, length) =
    length/segment_count;
    
function getDiameter(cord_length, start, tail, segments, ratio) =
    let(
        useable_length = wrapLength(cord_length, start, tail),
        length = segmentLength(segments, useable_length),
        circ = length * ratio )
    circ / PI;
    
function getStraight(cord_length, start, tail, segments, ratio) =
    let(
        useable_length = wrapLength(cord_length, start, tail),
        length = segmentLength(segments, useable_length)
        )
    (ratio * length)/2;

function calcCordEnd(cord_len, l, d) =
    // will return the remiander of the cord in mm
    let(rev_dist = d*PI + l*2)
    echo(rev_dist)
    cord_len % rev_dist;
    
//echo(calcCordEnd(tot_cord_length, oblongy, in_dia));
//echo(girthx*PI);