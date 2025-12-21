window_set_size(1280, 720);

icon_x = 1272;
icon_y = 16;
icon_size = 32;

xps = 0;
ysp = 0;

_gravity_normal = 1
_gravity = _gravity_normal

// UI state flag
ui_show_animals = false;

// Core animal transformation stuff
current_animal = global.current_animal;
sprite_index = global.current_animal_sprite;
transformation_cooldown = 0;
is_grounded = true;

// Specific animal transformation stuff

#region AERIAL
    is_flying = false;
    aerial_jumps = 3;
    aerial_jump_timer = 0;
#endregion

#region AQUATIC
	_gravity_water = 0
    is_swimming = false
	water_enter_immediate_slow_down_factor = 0.4 // To reduce the falling speed of the player right when it enters the water
	water_enter_slow_down_factor = 0.02 // To slowly reduce the falling speed of the player when it enters the water
	in_water_steps_without_water_animal = 0 // Current steps inside the water without a water animal
	in_water_steps_allowed_without_water_animal = 60 // 2s - Max limit of steps inside the water without a water animal before the player dies
	water_movement_slow_down_factor = 0.9 // To reduce the speed of the player bellow water
#endregion

#region CLIMBER
    is_climbing = false
    left_wall = false
    rigth_wall = false
	wall_jump_speed_factor = 10 // To make a quick jump out of climbing mode
#endregion

#region STRONG
    push_power = 1; // tweak force
#endregion

// Step functions

function set_camera() {
	camera_set_view_pos(view_camera[0], x - (view_wport[0] / 2), y - (view_hport[0] / 2));
}

function check_menus() {
	if keyboard_check_pressed(ord("P")) {
	    room_goto(1);
    }

    if (keyboard_check_pressed(ord("B"))) {
        ui_show_animals = !ui_show_animals;
    }
}

function check_mouse() {
	var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    if (mouse_check_button_pressed(mb_left)) {
        if (point_in_rectangle(mx, my, icon_x, icon_y, icon_x + icon_size, icon_y + icon_size)) {
            ui_show_animals = !ui_show_animals;
        }
    }
}

// Transform

function transform() {
	if (transformation_cooldown > 0) {
	    transformation_cooldown -= 1;
    }
	if (transformation_cooldown > 0) return;
	
	if (keyboard_check_pressed(ord("0")) && (current_animal != "Human")) {
		transformation_cooldown = 120;
		sprite_index = sPlayer;
		current_animal = "Human";
	}
    if (keyboard_check_pressed(ord("1")) && (current_animal != "Bird")) {
		transformation_cooldown = 120;
		sprite_index = sP1Bird;
		current_animal = "Bird";
	}
	if (keyboard_check_pressed(ord("2")) && (current_animal != "Bear")) {
		transformation_cooldown = 120;
	    sprite_index = sP1Bear;
		current_animal = "Bear";
	}
	if (keyboard_check_pressed(ord("3")) && (current_animal != "Frog")) {
		transformation_cooldown = 120;
		sprite_index = sP1Frog;
		current_animal = "Frog";
	}
	if (keyboard_check_pressed(ord("4")) && (current_animal != "Cat")) {
		transformation_cooldown = 120;
		sprite_index = sP1Cat;
		current_animal = "Cat";
	}
	if (keyboard_check_pressed(ord("5")) && (current_animal != "Griffon")) {
		transformation_cooldown = 120;
		sprite_index = sP1Bear; // sP1Griffon
		current_animal = "Griffon";
	}
	
	discover_animal(current_animal);
}

// Class behaviors

function execute_behaviors() {
	general_behavior();
	aerial_behavior();
	aquatic_behavior();
	climber_behavior();
}

function general_behavior() {
	if place_meeting(x, y+1, oSolid) {
	    ysp = 0;
	    is_grounded = true;
		is_flying = false;
    }
}

function aerial_behavior() {
	if (not global.animals[? current_animal].aerial) {
		aerial_jumps = 3;
		aerial_jump_timer = 0;
		return;
	}
	
	if (aerial_jump_timer > 0) {
	    aerial_jump_timer -= 1;
    }
	
	if place_meeting(x, y+1, oSolid) {
		is_flying = false;
	    aerial_jumps = 3;
    }
	
	if (keyboard_check_pressed(vk_up) && !is_grounded) {
		is_flying = true;
	}
}

function aquatic_behavior() {
    if place_meeting(x, y, oWater) {
		
	    _gravity = _gravity_water
		
		// Slow down while entering the water
		ysp = lerp(ysp, 0, water_enter_slow_down_factor)
		
		if !is_swimming {
			ysp *= water_enter_immediate_slow_down_factor
		}
		
		if (not global.animals[? current_animal].aquatic) {
			in_water_steps_without_water_animal++
			// Player dies if it used a non aquatic animal inside water for too long
			if (in_water_steps_without_water_animal > in_water_steps_allowed_without_water_animal) {
			    in_water_steps_without_water_animal = 0
				die()
			}
		} else {
			in_water_steps_without_water_animal = 0
		}
		
		is_swimming = true
		is_grounded = false
		
	} else {
		_gravity = _gravity_normal
		is_swimming = false
	}
}

function climber_behavior() {
	is_climbing = false;
	
	if (not global.animals[? current_animal].climber) return;

    left_wall  = place_meeting(x - 1, y, oSolid);
    right_wall = place_meeting(x + 1, y, oSolid);
	
	if (left_wall || right_wall) {
		is_climbing = true;
		is_grounded = false;
		_gravity = 0;
		aerial_jumps = 3;
	}
}

// Movement

function prepare_move() {
	if keyboard_check(vk_left) {
	    if (is_swimming) {
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
	    if (is_swimming) {
		    xsp = 1 * water_movement_slow_down_factor;
	    }
	    else if (is_climbing && left_wall) {
		    xsp = 1 * wall_jump_speed_factor;
	    }
	    else {
	        xsp += 1;
	    }
    }

    if ( keyboard_check_pressed(vk_up) ) {
	    if ( is_grounded == true ){
		    ysp = -2 * _gravity;
		    is_grounded = false;
	    }
	    else if (is_swimming) {
		    ysp = -1 * water_movement_slow_down_factor;
	    }
	    else if ( is_flying && !is_climbing && aerial_jump_timer == 0 && aerial_jumps > 0 ) {
		    ysp = -2 * _gravity;
		    aerial_jump_timer += 10;
		    aerial_jumps--;
	    }
    }
	
	// If it is being hold
	if (keyboard_check(vk_up)) {
		if (is_climbing) {
		    ysp = -1
	    }
	}

    if ( keyboard_check_pressed(vk_down) ) {
	    if (is_swimming) {
		    ysp = 1 * water_movement_slow_down_factor;
		}
    }
	
	// If it is being hold
	if (keyboard_check(vk_down)) {
		if (is_climbing) {
		    ysp = 1
	    }
	}
}

function execute_move() {
	move_and_collide(xsp, ysp, oSolid);
	
    if (is_climbing) {
	    ysp = 0
    }

    if place_meeting(x, y, oFlag) {
		next_level();
    }

    if place_meeting(x, y, oSpike) {
	    die();
    }
}

// Util functions

function next_level() {
	global.current_animal = current_animal;
	global.current_animal_sprite = sprite_index;
	room_goto_next();
}

function die() {
	global.current_animal = current_animal;
	global.current_animal_sprite = sprite_index;
	room_persistent = false
	room_restart();
}
