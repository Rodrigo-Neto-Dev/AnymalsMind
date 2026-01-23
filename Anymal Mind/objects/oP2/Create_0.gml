// --- Health & States ---
hp = 3;
hp_max = 3;
spd = 4;

state = "normal"; // normal, stunned, downed, carrying
stun_timer = 0;

// --- Carrying ---
carry_item = noone;
drag_offset_x = 0;
drag_offset_y = 0;

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

function get_square_selected_item(player_x, player_y) {
	var square_selected_item = 0;
	with (oRoomUI) {
		square_selected_item = get_item_square_selected(player_x, player_y);
	}
	return square_selected_item;
}

function room_drop_item() {
    if (carry_item != noone) {
        carry_item.x = x;
        carry_item.y = y;
        carry_item = noone;
        state = "normal";
    }
}

function store_item(item_numb) {
	if (item_numb == -1) return false;
	if (carry_item == noone) return false;
	
	var square_to_place = -1;
	
	// Find unoccupied square starting at the intended one
	if (global.item_squares_stored[item_numb] == noone) square_to_place = item_numb;
	else {
		var num_item_squares = array_length(global.item_squares_stored);
	    for (var square = (item_numb + 1) % num_item_squares; square != item_numb; square = (square + 1) % num_item_squares) {
		    if (global.item_squares_stored[square] == noone) {
			    square_to_place = square;
				break;
		    }
	    }
	}
	if (square_to_place == -1) return false;
	
	// Store the item in the square
	global.item_squares_stored[square_to_place] = carry_item.object_index;
	instance_destroy(carry_item);
	carry_item = noone;
	
	return true;
}

function room_item_pickup() {
	var _item = instance_place(x, y, oItem);
	if (_item == noone) return false;
	
	carry_item = _item;
	carry_item.is_moving = 1;
	
	return true;
}

function pickup_item(item_numb) {
	if (item_numb == -1) return;
	if (carry_item != noone) return;
	
	var _item = global.item_squares_stored[item_numb];
	if (_item == noone) return;
	
	instance_create_layer(x, y, "PlayersEnemies", _item);
	carry_item = _item;
	carry_item.is_moving = 1;
	global.item_squares_stored[item_numb] = noone;
}

function take_damage(amount) {
    if (state == "downed") return;

    hp -= amount;
    room_drop_item();

    if (hp <= 0) {
        state = "downed";
    } else {
        state = "stunned";
        stun_timer = 10;
    }
}

function revive() {
    hp = hp_max;
    state = "normal";
}