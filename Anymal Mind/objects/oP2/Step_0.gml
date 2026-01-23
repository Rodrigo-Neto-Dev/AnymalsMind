switch (state) {
	case "stunned":
		stun_timer--;
		if (stun_timer <= 0) state = "normal";
		exit;
		
	case "downed":
		// No movement or actions
		exit;
}

cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);
cam_w = camera_get_view_width(view_camera[0]);
cam_h = camera_get_view_height(view_camera[0]);

nx = x + clamp(mouse_x - x, -spd, spd);
ny = y + clamp(mouse_y - y, -spd, spd);
 
x = nx;
y = ny;

x = clamp(x, cam_x, cam_x + cam_w);
y = clamp(y, cam_y, cam_y + cam_h);



if (mouse_check_button_pressed(key_ui_interact())) {
	// Animal square check
	var square_selected_and_state = get_square_selected(x, y);
	var square_selected = square_selected_and_state[0];
	var square_state = square_selected_and_state[1];

	if (0 <= square_selected and square_selected <= 3) select_animal(square_selected, square_state);
	
	// Item pickup in room
	if (!room_item_pickup()) {
		// Item square check
	    var item_square = get_square_selected_item(x, y);
	    pickup_item(item_square);
	}
}

if (carry_item != noone) {
	carry_item.x = x// + drag_offset_x;
	carry_item.y = y// + drag_offset_y;
}

if (mouse_check_button_released(key_ui_interact())) {
	var item_square = get_square_selected_item(x, y);
	store_item(item_square);
	if (!store_item(item_square)) {
		room_drop_item();
	}
}