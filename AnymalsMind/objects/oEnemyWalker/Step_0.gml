event_inherited();

// gravity
vsp += gravity;

// Horizontal move
var hsp = dir * spd;

// Turn around on wall
if (place_meeting(x + sign(hsp) * wall_check, y, oSolid)) {
    dir = -dir;
    hsp = dir * spd;
}

// Turn around at ledges (no ground ahead)
var fx = x + sign(hsp) * ground_check;
if (!place_meeting(fx, y + 1, oSolid)) {
    dir = -dir;
    hsp = dir * spd;
}

// Apply movement with collision
// Horizontal
if (!place_meeting(x + hsp, y, oSolid)) {
    x += hsp;
} else {
    // push out / flip if stuck
    dir = -dir;
}

// Vertical
if (!place_meeting(x, y + vsp, oSolid)) {
    y += vsp;
} else {
    // snap to ground/ceiling
    while (!place_meeting(x, y + sign(vsp), oSolid) && vsp != 0) {
        y += sign(vsp);
    }
    vsp = 0;
}