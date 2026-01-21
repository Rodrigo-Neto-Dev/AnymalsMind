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
check_mouse();

transform();
execute_behaviors();

#region BIRD
    if (current_animal == "Bird") {
		//
	}
#endregion

#region BEAR
    if (current_animal == "Bear") {
		//
	}
#endregion

#region FROG
    if (current_animal == "Frog") {
		//
	}
#endregion

#region CAT
    if (current_animal == "Cat") {
		//
	}
#endregion

#region GRIFFON -> BIRD + CAT
    if (current_animal == "Griffon") {
		//
    }
#endregion

prepare_move();
execute_move();

var p2 = instance_nearest(x, y, oP2);
if (p2 != noone && p2.state == "downed") {
	if (keyboard_check_pressed(ord("E"))) {
		p2.revive();
	}
}

p2 = instance_nearest(x, y, oP2);
if (p2 != noone && point_distance(x,y,p2.x,p2.y) < 24) {
    if (keyboard_check_pressed(ord("E")) && p2.carried_item != noone && held_item == ITEM.NONE) {
        held_item = p2.carried_item.item_id;
        with (p2.carried_item) instance_destroy();
        p2.carried_item = noone;
        p2.state = "normal";
    }
}