window_set_size(1280, 720);

icon_x = 1272;
icon_y = 16;
icon_size = 32;

xsp = 0;
ysp = 0;

_gravity_normal = 1
_gravity = _gravity_normal

background = layer_background_get_id(layer_get_id("Background"));
main_background_color = #28FF33;
current_background_music = sndMain;
prepare_background_music();

// Controls

open_pause_menu = ord("P");
open_inventory = ord("B");

up = vk_up;
down = vk_down;
left = vk_left;
right = vk_right;
left_released = false
right_released = false;

animal0 = ord("0");
animal1 = ord("1");
animal2 = ord("2");
animal3 = ord("3");
animal4 = ord("4");
animal5 = ord("5");

dash = ord("D");

// UI state flag
ui_show_animals = false;

// Obstacles
solid_objects = [oSolid, oExplodingBox];

// Core animal transformation stuff
current_animal = global.current_animal;
sprite_index = global.current_animal_sprite;
current_animation_states = global.current_animation_states;
transformation_cooldown = 0;

is_idle = true;
is_grounded = true;
// For animal special animations
steps_without_special = 0;
steps_allowed_without_special = 240;

// Specific animal transformation stuff

#region AERIAL
    is_flying = false;
    aerial_jumps = 3;
    aerial_jump_timer = 0;
#endregion

#region AQUATIC
	_gravity_water = 0;
    is_swimming = false;
	is_dashing = false;
	water_enter_immediate_slow_down_factor = 0.4; // To reduce the falling speed of the player right when it enters the water
	water_slow_down_factor = 0.03; // To slowly reduce the falling speed of the player in the water
	in_water_steps_without_water_animal = 0; // Current steps inside the water without a water animal
	in_water_steps_allowed_without_water_animal = 60; // 2s - Max limit of steps inside the water without a water animal before the player dies
	water_movement_slow_down_factor = 0.9; // To reduce the speed of the player bellow water
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

// Specific animals

#region HUMAN
    human_animation_states = ds_map_create();
	ds_map_add(human_animation_states, "idle", sPlayer);
	ds_map_add(human_animation_states, "special", sPlayer);
	ds_map_add(human_animation_states, "running", sPlayer);
	ds_map_add(human_animation_states, "jumping", sPlayer);
	ds_map_add(human_animation_states, "swimming", sPlayer);
#endregion

#region BIRD
    bird_animation_states = ds_map_create();
	ds_map_add(bird_animation_states, "idle", sP1Bird);
	ds_map_add(bird_animation_states, "special", sP1Bird);
	ds_map_add(bird_animation_states, "running", sP1Bird);
	ds_map_add(bird_animation_states, "jumping", sP1Bird);
	ds_map_add(bird_animation_states, "swimming", sP1Bird);
#endregion

#region BEAR
    bear_animation_states = ds_map_create();
	ds_map_add(bear_animation_states, "idle", sP1Bear);
	ds_map_add(bear_animation_states, "special", sP1Bear);
	ds_map_add(bear_animation_states, "running", sP1Bear);
	ds_map_add(bear_animation_states, "jumping", sP1Bear);
	ds_map_add(bear_animation_states, "swimming", sP1Bear);
#endregion

#region FROG
    frog_animation_states = ds_map_create();
	ds_map_add(frog_animation_states, "idle", sP1FrogIdle);
	ds_map_add(frog_animation_states, "special", sP1FrogCroak);
	ds_map_add(frog_animation_states, "running", sP1FrogRunning);
	ds_map_add(frog_animation_states, "jumping", sP1FrogJumping);
	ds_map_add(frog_animation_states, "swimming", sP1FrogSwimming);
	
	dash_cooldown = 60;
	dash_steps_until_next = 0;
	dash_distance = 96;
	dash_time = 3;
	dash_direction = 0;
#endregion

#region CAT
    cat_animation_states = ds_map_create();
	ds_map_add(cat_animation_states, "idle", sP1Cat);
	ds_map_add(cat_animation_states, "special", sP1Cat);
	ds_map_add(cat_animation_states, "running", sP1Cat);
	ds_map_add(cat_animation_states, "jumping", sP1Cat);
	ds_map_add(cat_animation_states, "swimming", sP1Cat);
#endregion

#region GRIFFON
    griffon_animation_states = ds_map_create();
	ds_map_add(griffon_animation_states, "idle", sP1Bear);
	ds_map_add(griffon_animation_states, "special", sP1Bear);
	ds_map_add(griffon_animation_states, "running", sP1Bear);
	ds_map_add(griffon_animation_states, "jumping", sP1Bear);
	ds_map_add(griffon_animation_states, "swimming", sP1Bear);
#endregion

// ---------------------------------------------------------------------- //

// Step functions

function set_camera() {
	camera_set_view_pos(view_camera[0], x - (view_wport[0] / 2), y - (view_hport[0] / 2));
}

function check_menus() {
	if keyboard_check_pressed(open_pause_menu) {
	    room_goto(1);
    }

    if (keyboard_check_pressed(open_inventory)) {
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
	
	if (keyboard_check_pressed(animal0) && (current_animal != "Human")) {
		transformation_cooldown = 120;
		current_animal = "Human";
		current_animation_states = human_animation_states;
	}
    if (keyboard_check_pressed(animal1) && (current_animal != "Bird")) {
		transformation_cooldown = 120;
		current_animal = "Bird";
		current_animation_states = bird_animation_states;
	}
	if (keyboard_check_pressed(animal2) && (current_animal != "Bear")) {
		transformation_cooldown = 120;
		current_animal = "Bear";
		current_animation_states = bear_animation_states;
	}
	if (keyboard_check_pressed(animal3) && (current_animal != "Frog")) {
		transformation_cooldown = 120;
		current_animal = "Frog";
		current_animation_states = frog_animation_states;
	}
	if (keyboard_check_pressed(animal4) && (current_animal != "Cat")) {
		transformation_cooldown = 120;
		current_animal = "Cat";
		current_animation_states = cat_animation_states;
	}
	if (keyboard_check_pressed(animal5) && (current_animal != "Griffon")) {
		transformation_cooldown = 120;
		sprite_index = sP1Griffon;
		current_animal = "Griffon";
		current_animation_states = griffon_animation_states;
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
	if (not holding_any_movement_key()) {
		is_idle = true;
	}
	else {
		is_idle = false;
	}
}

function aerial_behavior() {
	if (not global.animals[? current_animal].aerial) {
		is_flying = false;
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
	
	if (keyboard_check_pressed(up) && !is_grounded) {
		is_flying = true;
	}
}

function aquatic_behavior() {
    if place_meeting(x, y, oWater) {
		
		set_background(sBackWater, -1, sndWater);
		
	    _gravity = _gravity_water;
		
		// Slow down while in the water
		ysp = lerp(ysp, 0, water_slow_down_factor);
		
		if (!is_swimming) {
			ysp *= water_enter_immediate_slow_down_factor;
			instance_create_layer(x, y, "Effects", oWaterSplash);
		}
		
		// Spawn bubble in random steps
		if (random_range(0, 100) <= 1) {
			instance_create_layer(x, y - 10, "Effects", oWaterBubble);
		}
		
		if (not global.animals[? current_animal].aquatic) {
			in_water_steps_without_water_animal++;
			// Player dies if it used a non aquatic animal inside water for too long
			if (in_water_steps_without_water_animal > in_water_steps_allowed_without_water_animal) {
			    in_water_steps_without_water_animal = 0;
				die();
			}
		} else {
			in_water_steps_without_water_animal = 0;
			if (dash_steps_until_next > 0) dash_steps_until_next--; // Needs more time until next dash
		}
		
		is_swimming = true;
		is_grounded = false;
		
	} else {
		set_background(sBack, main_background_color, sndMain);
		_gravity = _gravity_normal;
		is_swimming = false;
		image_yscale = 1;
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
	if keyboard_check(left) {
		image_xscale = -1; // Mirror image (turn left)
		
	    if (is_swimming) {
			xsp = -1 * water_movement_slow_down_factor;
			if (!is_idle) {
				sprite_index = current_animation_states[? "swimming"];
			}
	    }
	    else if (is_climbing && right_wall) {
		    xsp = -1 * wall_jump_speed_factor;
	    }
	    else {
	        xsp = -1;
			sprite_index = current_animation_states[? "running"];
	    }
    }
	
	if (keyboard_check_released(left)) {
		if (is_swimming) {
			left_released = true;
		}
	}
	
	if (left_released) {
		xsp = lerp(xsp, 0, water_slow_down_factor);
		if (xsp == 0) {
			left_released = false;
		}
	}

    if keyboard_check(right) {
		image_xscale = 1; // Turn right
		
	    if (is_swimming) {
		    xsp = 1 * water_movement_slow_down_factor;
			if (!is_idle) {
				sprite_index = current_animation_states[? "swimming"];
			}
	    }
	    else if (is_climbing && left_wall) {
		    xsp = 1 * wall_jump_speed_factor;
	    }
	    else {
	        xsp = 1;
			sprite_index = current_animation_states[? "running"];
	    }
    }
	
	if (keyboard_check_released(right)) {
		if (is_swimming) {
			right_released = true;
		}
	}
	
	if (right_released) {
		xsp = lerp(xsp, 0, water_slow_down_factor);
		if (xsp == 0) {
			right_released = false;
		}
	}

    if ( keyboard_check_pressed(up) ) {
	    if ( is_grounded == true ){
		    ysp = -2 * _gravity;
		    is_grounded = false;
			sprite_index = current_animation_states[? "jumping"];
	    }
	    else if ( is_flying && !is_swimming && !is_climbing && aerial_jump_timer == 0 && aerial_jumps > 0 ) {
		    ysp = -2 * _gravity;
		    aerial_jump_timer += 10;
		    aerial_jumps--;
	    }
    }
	
	// If it is being hold
	if (keyboard_check(up)) {
		if (is_swimming) {
		    ysp = -1 * water_movement_slow_down_factor;
			image_yscale = 1;
			if (!is_idle) {
				sprite_index = current_animation_states[? "swimming"];
			}
	    }
		else if (is_climbing) {
		    ysp = -1
	    }
	}

    if ( keyboard_check_pressed(down) ) {
	    //
    }
	
	// If it is being hold
	if (keyboard_check(down)) {
		if (is_swimming) {
		    ysp = 1 * water_movement_slow_down_factor;
			image_yscale = -1;
			if (!is_idle) {
				sprite_index = current_animation_states[? "swimming"];
			}
		}
		else if (is_climbing) {
		    ysp = 1
	    }
	}
	
	// Idle
	if (is_idle) {
		sprite_index = current_animation_states[? "idle"];
		steps_without_special++;
		
		if (steps_without_special >= steps_allowed_without_special) {
			sprite_index = current_animation_states[? "special"];
		}
	}
	else {
		steps_without_special = 0;
	}
	
	// Underwater dash
	if (keyboard_check_pressed(dash) && holding_any_movement_key()) {
		if (is_swimming && dash_steps_until_next == 0) {
			dash_steps_until_next = dash_cooldown;
			is_dashing = true;
			dash_direction = point_direction(0, 0, keyboard_check(right) - keyboard_check(left), keyboard_check(down) - keyboard_check(up));
			dash_speed = dash_distance / dash_time;
			dash_energy = dash_distance;
			execute_dash();
		}
	}
}

function execute_move() {
	if (is_dashing) {
	    var boxes_dashed = ds_list_create();
	    collision_line_list(x, y, x + xsp, y + ysp, oExplodingBox, true, true, boxes_dashed, true);
	
	    for (var i = 0; i < ds_list_size(boxes_dashed); i++) {
		    with (ds_list_find_value(boxes_dashed, i)) {
		        image_speed = 1; // Animate box explosion
		    }
	    }
	
	    ds_list_destroy(boxes_dashed);
		move_and_collide(xsp, ysp, oSolid);
	}
	else move_and_collide(xsp, ysp, solid_objects);
	
    if (is_climbing) {
	    ysp = 0
    }

    if place_meeting(x, y, oFlag) {
		next_level();
    }

    if place_meeting(x, y, oSpike) {
	    die();
    }
	
	unstuck();
}

// Util functions

function prepare_background_music() {
	// Play
	audio_play_sound(sndMain, 10, true);
	audio_play_sound(sndWater, 10, true);
	
	// Pause
	audio_pause_sound(sndWater);
}

// To unstuck the animal if it gets stuck after transforming
function unstuck() {
	if (place_meeting(x, y, solid_objects)) {
		for (var i = 1; i < 1000; i++) {
			// Right
			if (!place_meeting(x + i, y, solid_objects)) {
				x += i;
				break;
			}
			
			// Left
			if (!place_meeting(x - i, y, solid_objects)) {
				x -= i;
				break;
			}
			
			// Up
			if (!place_meeting(x, y - i, solid_objects)) {
				y -= i;
				break;
			}
			
			// Down
			if (!place_meeting(x, y + i, solid_objects)) {
				y += i;
				break;
			}
			
			// Top right
			if (!place_meeting(x + i, y - i, solid_objects)) {
				x += i;
				y -= i;
				break;
			}
			
			// Top left
			if (!place_meeting(x - i, y - i, solid_objects)) {
				x -= i;
				y -= i;
				break;
			}
			
			// Bottom right
			if (!place_meeting(x + i, y + i, solid_objects)) {
				x += i;
				y += i;
				break;
			}
			
			// Bottom left
			if (!place_meeting(x - i, y + i, solid_objects)) {
				x -= i;
				y += i;
				break;
			}
		}
	}
}

function holding_any_movement_key() {
	return keyboard_check(up) || keyboard_check(down) || keyboard_check(left) || keyboard_check(right);
}

function execute_dash() {
	xsp = lengthdir_x(dash_speed, dash_direction);
	ysp = lengthdir_y(dash_speed, dash_direction);
	
	// Trail effect
	with (instance_create_depth(x, y, depth + 1, oDashTrail)) {
		sprite_index = other.sprite_index;
		image_index = other.image_index;
		image_xscale = other.image_xscale;
		image_yscale = other.image_yscale;
		image_blend = c_white;
		image_alpha = 0.7;
	}
	
	dash_energy -= dash_speed;
	if (dash_energy <= 0) {
		is_dashing = false;
	}
}

function set_background(back, color, sound) {
	layer_background_change(background, back);
	layer_background_blend(background, color);
	if (current_background_music != sound) {
		audio_pause_sound(current_background_music);
		audio_resume_sound(sound);
	    current_background_music = sound;
	}
}

function next_level() {
	global.current_animal = current_animal;
	global.current_animal_sprite = sprite_index;
	global.current_animation_states = current_animation_states;
	audio_pause_sound(current_background_music);
	room_goto_next();
}

function die() {
	global.current_animal = current_animal;
	global.current_animal_sprite = sprite_index;
	global.current_animation_states = current_animation_states;
	audio_pause_sound(current_background_music);
	room_persistent = false
	room_restart();
}
