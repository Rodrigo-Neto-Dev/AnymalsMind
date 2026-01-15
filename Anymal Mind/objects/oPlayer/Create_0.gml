icon_x = 1272;
icon_y = 16;
icon_size = 32;

xsp = 0;
ysp = 0;

_gravity_normal = 1
_gravity = _gravity_normal

left_released = false
right_released = false;

// UI state flag
ui_show_animals = false;

// Core animal transformation stuff
current_animal = global.current_animal;
sprite_index = global.current_animal_sprite;
current_animation_states = global.current_animation_states;

// For animal special animations
steps_without_special = 0;
steps_allowed_without_special = 240;

// Specific animal transformation stuff

#region AERIAL
    aerial_jumps = 3;
    aerial_jump_timer = 0;
#endregion

#region AQUATIC
	_gravity_water = 0;
	water_enter_immediate_slow_down_factor = 0.4; // To reduce the falling speed of the player right when it enters the water
	water_slow_down_factor = 0.03; // To slowly reduce the falling speed of the player in the water
	in_water_steps_without_water_animal = 0; // Current steps inside the water without a water animal
	in_water_steps_allowed_without_water_animal = 60; // 2s - Max limit of steps inside the water without a water animal before the player dies
	water_movement_slow_down_factor = 0.9; // To reduce the speed of the player bellow water
#endregion

#region CLIMBER
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
	ds_map_add(griffon_animation_states, "idle", sP1Griffon);
	ds_map_add(griffon_animation_states, "special", sP1Griffon);
	ds_map_add(griffon_animation_states, "running", sP1Griffon);
	ds_map_add(griffon_animation_states, "jumping", sP1Griffon);
	ds_map_add(griffon_animation_states, "swimming", sP1Griffon);
#endregion

animal_to_animation_states = ds_map_create();
ds_map_add(animal_to_animation_states, "Human", human_animation_states);
ds_map_add(animal_to_animation_states, "Bird", bird_animation_states);
ds_map_add(animal_to_animation_states, "Bear", bear_animation_states);
ds_map_add(animal_to_animation_states, "Frog", frog_animation_states);
ds_map_add(animal_to_animation_states, "Cat", cat_animation_states);
ds_map_add(animal_to_animation_states, "Griffon", griffon_animation_states);

// ---------------------------------------------------------------------- //

// Step functions

function set_camera() {
	camera_set_view_pos(view_camera[0], x - (view_wport[0] / 2), y - (view_hport[0] / 2));
}

function check_menus() {
	if (keyboard_check_pressed(key_open_pause_menu())) {
	    room_goto(1);
    }

    if (keyboard_check_pressed(key_open_inventory())) {
        ui_show_animals = !ui_show_animals;
    }
}

function check_mouse() {
	var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    if (mouse_check_button_pressed(key_ui_interact())) {
        if (point_in_rectangle(mx, my, icon_x, icon_y, icon_x + icon_size, icon_y + icon_size)) {
            ui_show_animals = !ui_show_animals;
        }
    }
}

// Transform

function transform() {
	var player_animal = get_player_current_animal();
	if (player_animal == current_animal) return;
	
	current_animal = player_animal;
	current_animation_states = animal_to_animation_states[? player_animal];
	
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
	    addP1State(P1State.GROUNDED);
		delP1State(P1State.FLYING);
    }
	if (not holding_any_movement_key()) {
		addP1State(P1State.IDLE);
	}
	else {
		delP1State(P1State.IDLE);
	}
}

function aerial_behavior() {
	if (not global.animals[? current_animal].aerial) {
		delP1State(P1State.FLYING);
		aerial_jumps = 3;
		aerial_jump_timer = 0;
		return;
	}
	
	if (aerial_jump_timer > 0) {
	    aerial_jump_timer -= 1;
    }
	
	if place_meeting(x, y+1, oSolid) {
		delP1State(P1State.FLYING);
	    aerial_jumps = 3;
    }
	
	if (movement_check("up", "pressed") && !containsP1State(P1State.GROUNDED)) {
		addP1State(P1State.FLYING);
	}
}

function aquatic_behavior() {
    if place_meeting(x, y, oWater) {
		
	    _gravity = _gravity_water;
		
		// Slow down while in the water
		ysp = lerp(ysp, 0, water_slow_down_factor);
		
		if (!containsP1State(P1State.SWIMMING)) {
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
		
		addP1State(P1State.SWIMMING);
		delP1State(P1State.GROUNDED);
		
	} else {
		_gravity = _gravity_normal;
		delP1State(P1State.SWIMMING);
	}
}

function climber_behavior() {
	delP1State(P1State.CLIMBING);
	
	if (not global.animals[? current_animal].climber) return;

    left_wall  = place_meeting(x - 1, y, oSolid);
    right_wall = place_meeting(x + 1, y, oSolid);
	
	if (left_wall || right_wall) {
		addP1State(P1State.CLIMBING);
		delP1State(P1State.GROUNDED);
		_gravity = 0;
		aerial_jumps = 3;
	}
}

// Movement

function prepare_move() {
	var water_rotation_angles = ds_list_create();
	
	if (movement_check("left", "hold")) {
		image_xscale = -1; // Mirror image (turn left)
		
	    if (containsP1State(P1State.SWIMMING)) {
			xsp = -1 * water_movement_slow_down_factor;
			ds_list_add(water_rotation_angles, 180);
			if (!containsP1State(P1State.IDLE)) {
				sprite_index = current_animation_states[? "swimming"];
			}
	    }
	    else if (containsP1State(P1State.CLIMBING) && right_wall) {
		    xsp = -1 * wall_jump_speed_factor;
	    }
	    else {
	        xsp = -1;
			sprite_index = current_animation_states[? "running"];
	    }
    }
	
	if (movement_check("left", "released")) {
		if (containsP1State(P1State.SWIMMING)) {
			left_released = true;
		}
	}
	
	if (left_released) {
		xsp = lerp(xsp, 0, water_slow_down_factor);
		if (xsp == 0) {
			left_released = false;
		}
	}

    if (movement_check("right", "hold")) {
		image_xscale = 1; // Turn right
		
	    if (containsP1State(P1State.SWIMMING)) {
		    xsp = 1 * water_movement_slow_down_factor;
			ds_list_add(water_rotation_angles, 0);
			if (!containsP1State(P1State.IDLE)) {
				sprite_index = current_animation_states[? "swimming"];
			}
	    }
	    else if (containsP1State(P1State.CLIMBING) && left_wall) {
		    xsp = 1 * wall_jump_speed_factor;
	    }
	    else {
	        xsp = 1;
			sprite_index = current_animation_states[? "running"];
	    }
    }
	
	if (movement_check("right", "released")) {
		if (containsP1State(P1State.SWIMMING)) {
			right_released = true;
		}
	}
	
	if (right_released) {
		xsp = lerp(xsp, 0, water_slow_down_factor);
		if (xsp == 0) {
			right_released = false;
		}
	}

    if (movement_check("up", "pressed")) {
	    if (containsP1State(P1State.GROUNDED)) {
		    ysp = -2 * _gravity;
		    delP1State(P1State.GROUNDED);
			sprite_index = current_animation_states[? "jumping"];
	    }
	    else if (containsP1State(P1State.FLYING) && !containsP1State(P1State.SWIMMING) && !containsP1State(P1State.CLIMBING) && aerial_jump_timer == 0 && aerial_jumps > 0 ) {
		    ysp = -2 * _gravity;
		    aerial_jump_timer += 10;
		    aerial_jumps--;
	    }
    }
	
	if (movement_check("up", "hold")) {
		if (containsP1State(P1State.SWIMMING)) {
		    ysp = -1 * water_movement_slow_down_factor;
			ds_list_add(water_rotation_angles, 90);
			if (!containsP1State(P1State.IDLE)) {
				sprite_index = current_animation_states[? "swimming"];
			}
	    }
		else if (containsP1State(P1State.CLIMBING)) {
		    ysp = -1
	    }
	}

    if (movement_check("down", "pressed")) {
	    //
    }
	
	if (movement_check("down", "hold")) {
		if (containsP1State(P1State.SWIMMING)) {
		    ysp = 1 * water_movement_slow_down_factor;
			ds_list_add(water_rotation_angles, 270);
			if (!containsP1State(P1State.IDLE)) {
				sprite_index = current_animation_states[? "swimming"];
			}
		}
		else if (P1State.CLIMBING) {
		    ysp = 1
	    }
	}
	
	// Idle
	if (containsP1State(P1State.IDLE)) {
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
	if (keyboard_check_pressed(key_dash()) && holding_any_movement_key()) {
		if (containsP1State(P1State.SWIMMING) && dash_steps_until_next == 0) {
			dash_steps_until_next = dash_cooldown;
			addP1State(P1State.DASHING);
			dash_direction = point_direction(0, 0, keyboard_check(key_right()) - keyboard_check(key_left()), keyboard_check(key_down()) - keyboard_check(key_up()));
			dash_speed = dash_distance / dash_time;
			dash_energy = dash_distance;
			execute_dash();
		}
	}
	
	// Underwater angle
	image_angle = get_angle_in_water(water_rotation_angles, image_xscale);
	ds_list_destroy(water_rotation_angles);
}

function execute_move() {
	if (containsP1State(P1State.DASHING)) {
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
	else move_and_collide(xsp, ysp, get_obstacles());
	
    if (containsP1State(P1State.CLIMBING)) {
	    ysp = 0
    }

    if place_meeting(x, y, oFlag) {
		next_level();
    }

    if place_meeting(x, y, oSpike) {
	    die();
    }
	
	var player_coords = unstuck(x, y);
	x = player_coords[0];
	y = player_coords[1];
}

// Util Functions

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
		delP1State(P1State.DASHING);
	}
}

function next_level() {
	global.current_animal = current_animal;
	global.current_animal_sprite = sprite_index;
	global.current_animation_states = current_animation_states;
	global.current_level++;
	room_goto_next();
}

function die() {
	global.current_animal = current_animal;
	global.current_animal_sprite = sprite_index;
	global.current_animation_states = current_animation_states;
	room_persistent = false
	room_restart();
	dec_lives();
}
