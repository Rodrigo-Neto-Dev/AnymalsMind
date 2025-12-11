window_set_size(1280, 720);

icon_x = 1272;
icon_y = 16;
icon_size = 32;

xps = 0;
ysp = 0;

// core animal transformation stuff
current_animal = "normal";
transformation_cooldown = 0;

// specific animal transformation stuff
bird_jumps = 3;
bird_jump_timer = 0;

#region FROG
    _gravity_normal = 1
    _gravity_swimming = 0
    _gravity = _gravity_normal
    
    in_water = false
#endregion


// states ( for animations etc)
is_grounded = true;

// Define all possible animals/transformations

// UI state flag
ui_show_animals = false;
