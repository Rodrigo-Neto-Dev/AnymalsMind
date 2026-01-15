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
	
	if (square_selected == -1 || 5 <= square_selected) return;
	if (0 <= square_selected and square_selected <= 3) select_animal(square_selected, square_state);
}
