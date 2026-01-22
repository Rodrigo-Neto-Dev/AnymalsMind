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

//if (!place_meeting(nx, y, oSolid)) 
x = nx;
//if (!place_meeting(x, ny, oSolid)) 
y = ny;

x = clamp(x, cam_x, cam_x + cam_w);
y = clamp(y, cam_y, cam_y + cam_h);



if (mouse_check_button_pressed(key_ui_interact())) {
	var square_selected_and_state = get_square_selected(x, y);
	var square_selected = square_selected_and_state[0];
	var square_state = square_selected_and_state[1];

	if (0 <= square_selected and square_selected <= 3) select_animal(square_selected, square_state);
	

}



// Pick up item
if (mouse_check_button_pressed(mb_left)) {
	if carry_item = noone {

		var inst_item = instance_place(x, y, oItem);

		var pick_up_item_id = get_square_selected_item(x, y);

		if (inst_item != noone) {

			pickup_item(pick_up_item_id)

			carry_item = inst_item;

			carry_item.is_moving = 1;

			carry_item.is_stored = 0;


// Store offset so item doesn't snap

			drag_offset_x = inst_item.x - x;

			drag_offset_y = inst_item.y - y;

		}

	}

}





if (carry_item != noone) {

	carry_item.x = x + drag_offset_x;

	carry_item.y = y + drag_offset_y;

}

if (mouse_check_button_released(mb_left)) {
	
	if (carry_item != noone) {
	
		var store_item_id = get_square_selected_item(x, y);

		store_item(store_item_id);

		if store_item_id < 0 {

			if carry_item.item_has_collision = 1 {
				carry_item.is_moving = 0;
			}
			else {
				carry_item.is_moving = 1;
			}
			
			carry_item = noone;

		}

	}
}

