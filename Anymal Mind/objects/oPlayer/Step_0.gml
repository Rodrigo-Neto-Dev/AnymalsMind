ysp += 0.1 * _gravity;
if (!containsP1State(P1State.SWIMMING)) {
	xsp = 0;
	if (containsP1State(P1State.DASHING)) {
		ysp = 0;
		delP1State(P1State.DASHING);
	}
}

set_camera();
check_menus();

transform();
execute_behaviors();

#region SPECIFIC ANIMAL EXTRA BEHAVIOR
    // Activate/Deactivate swimming and climbing
    if (current_animal == "Blobfish" && place_meeting(x, y, oWater)) {
		if (keyboard_check_pressed(key_special())) {
			ignore_swimming_climbing_states = containsP1State(P1State.SWIMMING);
		    if (ignore_swimming_climbing_states) {
				delP1State(P1State.SWIMMING);
				delP1State(P1State.CLIMBING)
				_gravity = _gravity_normal;
			}
		    else {
				addP1State(P1State.SWIMMING);
				_gravity = _gravity_water;
			}
		}
	}
	else ignore_swimming_climbing_states = false;
#endregion


prepare_move();
execute_move();

jumper_bounce_check();


var p2 = instance_nearest(x, y, oP2);
if (p2 != noone && p2.state == "downed") {
	if (keyboard_check_pressed(ord("E"))) {
		p2.revive();
	}
}
