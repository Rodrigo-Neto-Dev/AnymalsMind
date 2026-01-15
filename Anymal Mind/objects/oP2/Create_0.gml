cam_x = 0;
cam_y = 0;
cam_w = 0;
cam_h = 0;

spd = 4;

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