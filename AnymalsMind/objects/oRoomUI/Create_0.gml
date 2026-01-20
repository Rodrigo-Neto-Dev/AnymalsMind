width = display_get_gui_width();
height = display_get_gui_height();

rectangle_width = width;
rectangle_height = height / 8;
rectangle_alpha = 0.2;
top_rectangle_color = c_grey;
bottom_rectangle_color = c_grey;
bottom_rect_yorigin = height - rectangle_height;

// Top
text_xscale = 5;
text_yscale = 5;

// Lives
lives_color = c_aqua;
lives_icon = sElephantIcon;

// Level
level_color = c_aqua;

// Bottom
square_side_length = width / 10;
square_outline_color = c_black;
square_alpha = 0.6;

// Animals
first_unmerged_animal_index = 1;
last_unmerged_animal_index = 4;
animal_scale = 4;

animal_unselected_background_color = c_green;
animal_selected_background_color = c_lime;

// Items
item_background_color = c_silver;

function draw_lives() {
	var lives_str = string(global.lives);
	text(lives_str, 20, rectangle_height / 2, fn30, fa_center, fa_center, lives_color, 1);
	draw_sprite(lives_icon, 0, 20 + string_width(lives_str) + 20, rectangle_height / 2);
}

function draw_current_level() {
	var level_str = "LEVEL " + string(global.current_level);
	text(level_str, width - string_width(level_str) / 2 - 20, rectangle_height / 2, fn30, fa_center, fa_center, level_color, 1);
}

function draw_animals() {
	var inc = square_side_length;
	var draw_x = 0;
	var draw_y = bottom_rect_yorigin + rectangle_height / 2;
	
	var animal_back_color;
	
	for (var i = first_unmerged_animal_index; i <= last_unmerged_animal_index; i++) {
		var animal_name = global.animal_names[i];
		var animal = global.animals[? animal_name];
		
		// Look at the array with the states of each square (selected or not) and choose the right color
		var animal_squares_selected_index = i - first_unmerged_animal_index;
		if (global.animal_squares_selected[animal_squares_selected_index]) {
			animal_back_color = animal_selected_background_color;
		} else {
			animal_back_color = animal_unselected_background_color;
		}
		
		// Square
		draw_set_alpha(square_alpha);
		draw_rectangle_colour(
		    draw_x, draw_y - rectangle_height / 2, draw_x + inc, draw_y + rectangle_height / 2,
			animal_back_color, animal_back_color, animal_back_color, animal_back_color,
			false
		);
		draw_set_alpha(1);
		// Square Outline
		draw_rectangle_colour(
		    draw_x, draw_y - rectangle_height / 2, draw_x + inc, draw_y + rectangle_height / 2,
			square_outline_color, square_outline_color, square_outline_color, square_outline_color,
			true
		);
		
		if (animal.discovered) {
			draw_sprite_ext(
			    animal.sprite, 0,
				draw_x + inc / 2, height - inc / 8,
				animal_scale, animal_scale,
				0, c_white, 1
			);
		}
		
		draw_x += inc;
	}
}

function draw_items() {
	var inc = square_side_length;
	var draw_x = inc * (last_unmerged_animal_index - first_unmerged_animal_index + 1) + inc;
	var draw_y = bottom_rect_yorigin + rectangle_height / 2;
	
	for (var i = 0; i < 5; i++) { // TODO -> items.length
		// TODO -> get item
		
		// Square
		draw_set_alpha(square_alpha);
		draw_rectangle_colour(
		    draw_x, draw_y - rectangle_height / 2, draw_x + inc, draw_y + rectangle_height / 2,
			item_background_color, item_background_color, item_background_color, item_background_color,
			false
		);
		draw_set_alpha(1);
		// Square Outline
		draw_rectangle_colour(
		    draw_x, draw_y - rectangle_height / 2, draw_x + inc, draw_y + rectangle_height / 2,
			square_outline_color, square_outline_color, square_outline_color, square_outline_color,
			true
		);
		
		// TODO -> draw item just like the animals (with the discovered condition too...maybe)
		
		draw_x += inc;
	}
}

function set_square_selected(player_x, player_y) {
	var square_selected = -1;
	var square_state = false;
	
	var num_animals = last_unmerged_animal_index - first_unmerged_animal_index + 1;
	
	var gui_coords = room_to_gui_coords(player_x, player_y);
	var gui_x = gui_coords[0];
	var gui_y = gui_coords[1];
	
	var inc = square_side_length;
	var curr_x = 0;
	var curr_y = bottom_rect_yorigin + rectangle_height / 2;
	
	for (var i = 0; i < num_animals; i++) {
		if (point_in_rectangle(gui_x, gui_y, curr_x, curr_y - rectangle_height / 2, curr_x + inc, curr_y + rectangle_height / 2)) {
			square_selected = i;
			
			if (can_select_animal() && !global.animal_squares_selected[i]) {
			    global.animal_squares_selected[i] = true;
			} else {
				global.animal_squares_selected[i] = false;
			}
			
			square_state = global.animal_squares_selected[i];
			break;
		}
		curr_x += inc;
	}
	
	return [square_selected, square_state];
}

function can_select_animal() {
	var num_selected_animals = 0;
	
	for (var i = 0; i < array_length(global.animal_squares_selected); i++) {
		if (global.animal_squares_selected[i]) {
			num_selected_animals++;
		}
	}
	
	return num_selected_animals < 2;
}
