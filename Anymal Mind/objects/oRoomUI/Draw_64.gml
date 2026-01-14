draw_rectangle_colour(0, 0, rectangle_width, rectangle_height, top_rectangle_color, top_rectangle_color, top_rectangle_color, top_rectangle_color, false);
draw_lives();
draw_current_level();

draw_rectangle_colour(0, bottom_rect_yorigin, rectangle_width, height, bottom_rectangle_color, bottom_rectangle_color, bottom_rectangle_color, bottom_rectangle_color, false);
draw_animals();
draw_items();

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
	
	for (var i = first_unmerged_animal_index; i <= last_unmerged_animal_index; i++) {
		var animal_name = global.animal_names[i];
		var animal = global.animals[? animal_name];
		
		// Square
		draw_rectangle_colour(
		    draw_x, draw_y - rectangle_height / 2, draw_x + inc, draw_y + rectangle_height / 2,
			animal_background_color, animal_background_color, animal_background_color, animal_background_color,
			false
		);
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
		draw_rectangle_colour(
		    draw_x, draw_y - rectangle_height / 2, draw_x + inc, draw_y + rectangle_height / 2,
			item_background_color, item_background_color, item_background_color, item_background_color,
			false
		);
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