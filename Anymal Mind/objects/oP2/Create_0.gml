// --- Health & States ---
hp = 3;
hp_max = 3;
spd = 4;

state = "normal"; // normal, stunned, downed, carrying
stun_timer = 0;

// --- Carrying ---
carried_item = noone;
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

function drop_item() {
    if (carried_item != noone) {
        carried_item.x = x;
        carried_item.y = y;
        carried_item.visible = true;
        carried_item.active = true;
        carried_item = noone;
        state = "normal";
    }
}

function take_damage(amount) {
    if (state == "downed") return;

    hp -= amount;
    drop_item();

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

items = [noone, noone, noone, noone, noone];


function get_square_selected_item(player_x, player_y) {

	var square_selected_and_state_item = 0;

	with (oRoomUI) {

		square_selected_and_state_item = get_item_square_selected(player_x, player_y);

	}

	return square_selected_and_state_item;

}


function store_item(item_numb) {
	if (item_numb == -1) return;
	
	var cam_for_items = view_camera[0];
	var _item = items[item_numb];
	
	if (_item == noone) {
		carry_item.UI_offset_x = 0//carry_item.x - camera_get_view_x(cam_for_items);
		carry_item.UI_offset_y = 0//carry_item.y - camera_get_view_y(cam_for_items);
		carry_item.is_stored = 1;
		_item = carry_item;
		carry_item = noone;
	}
}


function pickup_item(item_numb) {
	if (item_numb == -1) return;
	
	if (items[item_numb] != noone) {
		items[item_numb] = noone;
	}
}