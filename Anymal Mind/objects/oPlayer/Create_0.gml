window_set_size(1280, 720);

icon_x = 1272;
icon_y = 16;
icon_size = 32;

xps = 0;
ysp = 0;

_gravity_normal = 1
_gravity = _gravity_normal

// core animal transformation stuff
current_animal = "normal";
transformation_cooldown = 0;

// specific animal transformation stuff
bird_jumps = 3;
bird_jump_timer = 0;

// CAT
cat_is_climbing = false;

// GRYPH
gryph_jumps = 3;
gryph_jump_timer = 0;

// BEAR (pushable objects)
bear_push_power = 1; // tweak force



#region FROG
	_gravity_water = 0
    in_water = false
	water_enter_immediate_slow_down_factor = 0.4 // To reduce the falling speed of the player right when it enters the water
	water_enter_slow_down_factor = 0.02 // To slowly reduce the falling speed of the player when it enters the water
	in_water_steps_without_water_animal = 0 // Current steps inside the water without a water animal
	in_water_steps_allowed_without_water_animal = 60 // 2s - Max limit of steps inside the water without a water animal before the player dies
	water_movement_slow_down_factor = 0.9 // To reduce the speed of the player bellow water
#endregion

#region CAT
    is_climbing = false
    left_wall = false
    rigth_wall = false
	wall_jump_speed_factor = 10 // To make a quick jump out of climbing mode
#endregion


// states ( for animations etc)
is_grounded = true;

// Define all possible animals/transformations

// UI state flag
ui_show_animals = false;
