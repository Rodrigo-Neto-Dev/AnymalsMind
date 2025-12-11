window_set_size(1280, 720);

xps = 0;
ysp = 0;

// core animal transformation stuff
current_animal = "normal";
transformation_cooldown = 0;

// specific animal transformation stuff
bird_jumps = 3;
bird_jump_timer = 0;

#region DOLPHIN
    _gravity_normal = 1
    _gravity_swimming = 0
    _gravity = _gravity_normal
    
    in_water = false
#endregion


// states ( for animations etc)
is_grounded = true;
