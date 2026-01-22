	event_inherited();

	var p2 = instance_find(oP2, 0);

	var tx, ty;
	var chasing = false;

	if (p2 != noone && p2.state != "downed") {
	    var d = point_distance(x, y, p2.x, p2.y);
	    if (d <= aggro_range) {
	        chasing = true;
	        tx = p2.x;
	        ty = p2.y;
	    }
	}

	if (!chasing) {
	    // go back near home and wander
	    var dh = point_distance(x, y, home_x, home_y);
	    if (dh > return_range) {
	        tx = home_x;
	        ty = home_y;
	    } else {
	        wander_phase += 3;
	        tx = home_x + lengthdir_x(wander_radius, wander_phase);
	        ty = home_y + lengthdir_y(wander_radius, wander_phase);
	    }
	}

	// Move toward target, stop if very close
	var dist = point_distance(x, y, tx, ty);
	if (dist > stop_range) {
	    var dir = point_direction(x, y, tx, ty);
	    var dx = lengthdir_x(spd, dir);
	    var dy = lengthdir_y(spd, dir);

	    // (Optional) avoid going inside solids: simple slide
	   //if (!place_meeting(x + dx, y, oSolid)) 
	   x += dx;
	   //if (!place_meeting(x, y + dy, oSolid)) 
	   y += dy;
	}