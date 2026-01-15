// To unstuck the animal if it gets stuck after transforming
function unstuck(player_x, player_y) {
	var solid_objects = get_obstacles();
	
	if (place_meeting(player_x, player_y, solid_objects)) {
		for (var i = 1; i < 1000; i++) {
			// Right
			if (!place_meeting(player_x + i, player_y, solid_objects)) {
				player_x += i;
				break;
			}
			
			// Left
			if (!place_meeting(player_x - i, player_y, solid_objects)) {
				player_x -= i;
				break;
			}
			
			// Up
			if (!place_meeting(player_x, player_y - i, solid_objects)) {
				player_y -= i;
				break;
			}
			
			// Down
			if (!place_meeting(player_x, player_y + i, solid_objects)) {
				player_y += i;
				break;
			}
			
			// Top right
			if (!place_meeting(player_x + i, player_y - i, solid_objects)) {
				player_x += i;
				player_y -= i;
				break;
			}
			
			// Top left
			if (!place_meeting(player_x - i, player_y - i, solid_objects)) {
				player_x -= i;
				player_y -= i;
				break;
			}
			
			// Bottom right
			if (!place_meeting(player_x + i, player_y + i, solid_objects)) {
				player_x += i;
				player_y += i;
				break;
			}
			
			// Bottom left
			if (!place_meeting(player_x - i, player_y + i, solid_objects)) {
				player_x -= i;
				player_y += i;
				break;
			}
		}
	}
	
	return [player_x, player_y];
}

function holding_any_movement_key() {
	return movement_check("up", "hold") || movement_check("down", "hold") || movement_check("left", "hold") || movement_check("right", "hold");
}

function movement_check(dir_string, type_string) {
	var dir = string_upper(dir_string);
	var type = string_upper(type_string);
	var move_func;
	
	switch (type) {
		case "HOLD": move_func = keyboard_check; break;
		case "PRESSED": move_func = keyboard_check_pressed; break;
		case "RELEASED": move_func = keyboard_check_released; break;
		default: move_func = keyboard_check; break;
	}
	
	switch (dir) {
		case "UP": return move_func(key_up()) or move_func(key_up_wasd());
		case "DOWN": return move_func(key_down()) or move_func(key_down_wasd());
		case "LEFT": return move_func(key_left()) or move_func(key_left_wasd());
		case "RIGHT": return move_func(key_right()) or move_func(key_right_wasd());
	}
	
	return false;
}

function get_angle_in_water(water_rotation_angles, xscale) {
	var mean_angle = 0.0;
	var use_next_circle = false;
	if (ds_list_find_index(water_rotation_angles, 0) != -1 and ds_list_find_index(water_rotation_angles, 270)) {
		use_next_circle = true;
	}
	
	for (var i = 0; i < ds_list_size(water_rotation_angles); i++) {
		var angle = water_rotation_angles[| i];
		if (angle != 270 and use_next_circle) {
			angle += 360;
		}
		mean_angle += angle;
	}
	if (not ds_list_empty(water_rotation_angles)) {
		mean_angle /= ds_list_size(water_rotation_angles);
	}
	
	if (xscale = -1 and mean_angle != 0) {
		mean_angle -= 180;
	}
	if (mean_angle >= 360 and use_next_circle) {
		mean_angle -= 360;
	}
	
	return mean_angle;
}

function room_to_gui_coords(room_x, room_y) {
	var cl = camera_get_view_x(view_camera[0]);
    var ct = camera_get_view_y(view_camera[0]);
       
    var off_x = room_x - cl;
    var off_y = room_y - ct;
       
    // Convert to gui
    var off_x_percent = off_x / camera_get_view_width(view_camera[0]);
    var off_y_percent = off_y / camera_get_view_height(view_camera[0]);
       
    var gui_x = off_x_percent * display_get_gui_width();
    var gui_y = off_y_percent * display_get_gui_height();
	
	return [gui_x, gui_y];
}

function dec_lives() {
	global.lives--;
	if (global.lives == 0) {
		game_over();
	}
}

function game_over() {
	room_goto(0);
	game_restart();
}
