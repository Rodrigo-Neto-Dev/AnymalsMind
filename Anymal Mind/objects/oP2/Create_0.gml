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

<<<<<<< HEAD
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
=======
item1 = noone;
item2 = noone;
item3 = noone;
item4 = noone;
item5 = noone;
item1_item = noone;
item2_item = noone;
item3_item = noone;
item4_item = noone;
item5_item = noone;

function get_square_selected_item(player_x, player_y) {
	var square_selected_and_state_item = 0;
	with (oRoomUI) {
		square_selected_and_state_item = get_item_square_selected(player_x, player_y);
	}
	return square_selected_and_state_item;
}

function store_item(item_numb) {
	var cam_for_items = view_camera[0];
	if item_numb = 0 {
		if item1 == noone {
			//layer_add_instance("UI", carry_item);
			carry_item.UI_offset_x = carry_item.x - camera_get_view_x(cam_for_items);
			carry_item.UI_offset_y = carry_item.y - camera_get_view_y(cam_for_items);
			carry_item.is_stored = 1;
			item1 = carry_item;
			carry_item = noone;
			// Old sulution, keeping it just in case i need it
			//var item1_item = instance_create_layer(carry_item.x, carry_item.y, "UI", temp_item)
			//item1_item.is_stored = 1;
			//item1 = temp_item
			//var temp_item2 = carry_item
			//carry_item = noone;
			//instance_destroy(temp_item2)

		
			
		}
		
	}
	if item_numb = 1 {
		if item2 == noone {
			layer_add_instance("UI", carry_item);
			carry_item.UI_offset_x = carry_item.x - camera_get_view_x(cam_for_items);
			carry_item.UI_offset_y = carry_item.y - camera_get_view_y(cam_for_items);
			carry_item.is_stored = 1;
			item2 = carry_item;
			carry_item = noone;
			
		}
		
	}
	if item_numb = 2 {
		if item3 == noone {
			layer_add_instance("UI", carry_item);
			carry_item.UI_offset_x = carry_item.x - camera_get_view_x(cam_for_items);
			carry_item.UI_offset_y = carry_item.y - camera_get_view_y(cam_for_items);
			carry_item.is_stored = 1;
			item3 = carry_item;
			carry_item = noone;
			
		}
		
	}
	if item_numb = 3 {
		if item4 == noone {
			layer_add_instance("UI", carry_item);
			carry_item.UI_offset_x = carry_item.x - camera_get_view_x(cam_for_items);
			carry_item.UI_offset_y = carry_item.y - camera_get_view_y(cam_for_items);
			carry_item.is_stored = 1;
			item4 = carry_item;
			carry_item = noone;
			
		}
		
	}
	if item_numb = 4 {
		if item5 == noone {
			layer_add_instance("UI", carry_item);
			carry_item.UI_offset_x = carry_item.x - camera_get_view_x(cam_for_items);
			carry_item.UI_offset_y = carry_item.y - camera_get_view_y(cam_for_items);
			carry_item.is_stored = 1;
			item5 = carry_item;
			carry_item = noone;
			
		}
		
	}
	
	
}

function pickup_item(item_numb) {
	
	if item_numb = 0 {
		if item1 != noone {
			item1 = noone;			
		}
		
	}
	
	if item_numb = 1 {
		if item2 != noone {
			item2 = noone;			
		}
		
	}
	
	if item_numb = 2 {
		if item3 != noone {
			item3 = noone;			
		}
		
	}
	
	if item_numb = 3 {
		if item4 != noone {
			item4 = noone;
		}
		
	}
	
	if item_numb = 4 {
		if item5 != noone {
			item5 = noone;
			
		}
		
	}
	
	
>>>>>>> bd7d01c930412d7961de492593fa23c1c22b0d14
}