ysp += 0.1 * _gravity
xsp = 0;

camera_set_view_pos(view_camera[0], x - (view_wport[0] / 2), y - (view_hport[0] / 2));

if keyboard_check_pressed(ord("P")) {
	room_goto(1)
}

if (keyboard_check_pressed(ord("B"))) {
    ui_show_animals = !ui_show_animals;
}

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mx, my, icon_x, icon_y, icon_x + icon_size, icon_y + icon_size)) {
        ui_show_animals = !ui_show_animals;
    }
}

// all variables that need to count down
if (transformation_cooldown > 0) {
	transformation_cooldown -= 1;
}

if (bird_jump_timer > 0) {
	bird_jump_timer -= 1;
}

if (gryph_jump_timer > 0) {
	gryph_jump_timer--;
}


#region TRANSFORMATION
if (transformation_cooldown == 0) {
	if (keyboard_check_pressed(ord("1")) && (current_animal != "Bird" )) {
		sprite_index = sP1Bird;
		transformation_cooldown = 120;
		current_animal = "Bird";
		discover_animal(current_animal)
	}
	if (keyboard_check_pressed(ord("2")) && (current_animal != "Bear" )) {
		sprite_index = sP1Bear;
		transformation_cooldown = 120;
		current_animal = "Bear";
		discover_animal(current_animal)
	}
	if (keyboard_check_pressed(ord("3")) && (current_animal != "Frog" ) ) {
		sprite_index = sP1Frog;
		transformation_cooldown = 120;
		current_animal = "Frog";
		discover_animal(current_animal)
	}

	if (keyboard_check_pressed(ord("4")) && (current_animal != "Cat" ) ) {
		sprite_index = sP1Cat;
		transformation_cooldown = 120;
		current_animal = "Cat";
		discover_animal(current_animal)
	}
	if (keyboard_check_pressed(ord("5")) && (current_animal != "Griffon" ) ) {
		sprite_index = sP1Bear; // sP1Griffon
		transformation_cooldown = 120;
		current_animal = "Griffon";
		discover_animal(current_animal)
	}
}
#endregion

#region SOLID CHECK
if place_meeting(x, y+1, oSolid) {
	ysp = 0;
	is_grounded = true;
	bird_jumps = 3;
	gryph_jumps = 3;
}
#endregion

#region FROG WATER CHECK
    if place_meeting(x, y, oWater) {
		
	    _gravity = _gravity_water
		
		// Slow down while entering the water
		ysp = lerp(ysp, 0, water_enter_slow_down_factor)
		
		if !in_water {
			ysp *= water_enter_immediate_slow_down_factor
		}
		
		if (current_animal != "Frog") {
			in_water_steps_without_water_animal++
			// Player dies if it used a non aquatic animal inside water for too long
			if (in_water_steps_without_water_animal > in_water_steps_allowed_without_water_animal) {
			    in_water_steps_without_water_animal = 0
				room_persistent = false
			    room_restart()
			}
		} else {
			in_water_steps_without_water_animal = 0
		}
		
		in_water = true
		is_grounded = false
		
	} else {
		_gravity = _gravity_normal
		in_water = false
	}
#endregion

#region CAT CLIMB
if (current_animal == "Cat") {

    is_climbing = false;
    
    left_wall  = place_meeting(x - 1, y, oSolid);
    right_wall = place_meeting(x + 1, y, oSolid);
	
	if (left_wall || right_wall) {
		is_climbing = true;
		is_grounded = false;
	}

    if (is_climbing) {
        _gravity = 0;
    }
}
#endregion

#region GRIFFON HYBRID LOGIC
if (current_animal == "Griffon") {

    is_climbing = false;

    left_wall  = place_meeting(x - 1, y, oSolid);
    right_wall = place_meeting(x + 1, y, oSolid);
	
	if (left_wall || right_wall) {
		is_climbing = true;
		is_grounded = false;
		_gravity = 0;
	}
}
#endregion

#region ARROW MOVEMENT
if keyboard_check(vk_left) {
	if (in_water) {
		xsp = -1 * water_movement_slow_down_factor;
	}
	else if (is_climbing && right_wall) {
		xsp = -1 * wall_jump_speed_factor;
	}
	else {
	    xsp = -1;
	}
}

if keyboard_check(vk_right) {
	if (in_water) {
		xsp = 1 * water_movement_slow_down_factor;
	}
	else if (is_climbing && left_wall) {
		xsp = 1 * wall_jump_speed_factor;
	}
	else {
	    xsp += 1;
	}
}

if ( keyboard_check_pressed(vk_up ) ) {
	if ( is_grounded == true ){
		ysp = -2 * _gravity;
		is_grounded = false;
	}
	else if (in_water) {
		ysp = -1 * water_movement_slow_down_factor;
	}
	else if ( (current_animal == "Bird") && (bird_jump_timer == 0) && (bird_jumps > 0) ) {
		ysp = -2 * _gravity;
		bird_jump_timer += 10;
		bird_jumps--;
	}
    else if (current_animal == "Griffon" && !is_climbing && gryph_jump_timer == 0 && gryph_jumps > 0) {
        ysp = -2 * _gravity;
        gryph_jump_timer = 10;
        gryph_jumps--;
    }
}

if ( keyboard_check(vk_up) ) {
	if (is_climbing) {
		ysp = -1
		gryph_jumps = 3
	}
}

if ( keyboard_check_pressed(vk_down) ) {
	if (in_water) {
		ysp = 1 * water_movement_slow_down_factor;
	}
}

if ( keyboard_check(vk_down) ) {
	if (is_climbing) {
		ysp = 1
	}
}
#endregion

move_and_collide(xsp, ysp, oSolid);

if (is_climbing) {
	ysp = 0
}

if place_meeting(x, y, oFlag) {
	room_goto_next();
}

if place_meeting(x, y, oSpike) {
	room_persistent = false
	room_restart();
}