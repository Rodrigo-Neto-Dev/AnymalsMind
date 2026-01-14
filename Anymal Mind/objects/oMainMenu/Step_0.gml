/// @description Actions

if global.reset_all_rooms[0] {
	global.reset_all_rooms[0] = false;
	room_goto(2);
}

// change menu item selected
var _change = keyboard_check_pressed(menu_down_buttom) - keyboard_check_pressed(menu_up_buttom);
var _previous_selected = selected;

// if there is change...
if _change != 0 {
	selected = clamp(selected + _change, 0, ds_list_size(menu) - 1);
	if selected != _previous_selected {
		audio_play_sound(sndSelect, 100, false);
	}
}

// when enter pressed, do what need to do based on the selected menu item
if keyboard_check_pressed(menu_confirmation_buttom) {
	audio_play_sound(sndConfirmation, 100, false);
	switch(selected) {
		case 0:	// New Game
			game_restart()
			break;
		case 1:	// Load Game
			room_goto(asset_get_index(global.room_save))
			break;
		case 2:	// Controls
			show_controls_ui = true;
			break;
		case 3: // Credits
			// add code of what to do when confirming this item
			break;
		case 4: // Exit Game
			game_end(0)
			break;
	}
}