// --- Health & States ---
hp = 3;
hp_max = 3;
spd = 4;

state = "normal"; // normal, stunned, downed, carrying
stun_timer = 0;

// --- Peck ---
peck_cooldown = 0;
peck_cooldown_max = 20;
peck_range = 16;
peck_damage = 1;

// --- Carrying ---
carried_item = noone;

// --- References ---
nest_ref = noone; // assigned at room start or by collision


cam_x = 0;
cam_y = 0;
cam_w = 0;
cam_h = 0;

nx = 0;
ny = 0;

function get_square_selected(player_x, player_y) {
	var square_selected_and_state = [];
	with (oRoomUI) {
		square_selected_and_state = set_square_selected(player_x, player_y);
	}
	return square_selected_and_state;
}

function select_animal(square_selected, square_state) {
	var add_or_del;
	if (square_state) {
		add_or_del = add_animal_selected;
	} else {
		add_or_del = del_animal_selected;
	}
	
	switch (square_selected) {
		case 0: add_or_del("Bird"); break;
		case 1: add_or_del("Bear"); break;
		case 2: add_or_del("Frog"); break;
		case 3: add_or_del("Cat"); break;
		default: break;
	}
}	