function open_control_menu() {
    // Semi-transparent or non-transparent dark background
    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
	
	var draw_x = room_width / 2;
	var draw_y = 20;
	var inc = room_height / 30;

    // Title
	shadowed_text("Controls", draw_x, draw_y, fn60, fa_center, fa_top, 5, c_aqua, c_gray, 1, 1);

    // Player 1 controls
	
    draw_y += 5 * inc;
	text("Player 1", draw_x, draw_y, fn30, fa_center, fa_top, c_orange, 1);
	draw_y += 2 * inc;
	
	draw_y = show_controls(p1_controls_array(), draw_x, draw_y, inc);
	
	// Player 2 controls
	
	draw_y += inc;
	text("Player 2", draw_x, draw_y, fn30, fa_center, fa_top, c_orange, 1);
	draw_y += 2 * inc;
	
	draw_y = show_controls(p2_controls_array(), draw_x, draw_y, inc);
	
	// Escape to leave
	
	draw_y = room_height - room_height / 15;
	draw_x -= room_width / 4;
	text("Press ESC to leave", draw_x, draw_y, fn30, fa_center, fa_top, c_white, 1);
}

function p1_controls_array() {
	var controls = [];
	
	controls_push(controls, "Pause Menu", "P");
	controls_push(controls, "Animal Inventory", "B");
	
	controls_push(controls, "Move/Swim left", "A or left arrow");
	controls_push(controls, "Move/Swim right", "D or right arrow");
	controls_push(controls, "Jump/Swim/Climb up", "W or up arrow");
	controls_push(controls, "Swim/Climb down", "S or down arrow");
	
	controls_push(controls, "Human transformation", "0");
	controls_push(controls, "Bird transformation", "1");
	controls_push(controls, "Bear transformation", "2");
	controls_push(controls, "Frog transformation", "3");
	controls_push(controls, "Cat transformation", "4");
	controls_push(controls, "Griffon transformation", "5");
	
	controls_push(controls, "Bird jump", "W or up arrow");
	
	controls_push(controls, "Frog underwater dash", "E");
	
	return controls;
}

function p2_controls_array() {
	var controls = [];
	
	controls_push(controls, "Move", "move mouse");
	
	return controls;
}

function show_controls(controls, draw_x, draw_y, inc) {
	var left_x = draw_x - room_width / 12;
	var right_x = draw_x + room_width / 12;
	
	for (var i = 0; i < array_length(controls); i++) {
		draw_set_color(c_lime);
		draw_text_transformed(left_x, draw_y, controls[i].command, 0.4, 0.4, 0);
		
		draw_set_color(c_white);
		draw_text_transformed(right_x, draw_y, controls[i].key, 0.4, 0.4, 0);
		
		draw_y += inc;
	}
	
	return draw_y;
}

function controls_push(controls, command_string, key_string) {
	array_push(controls, {command: command_string, key: key_string});
}