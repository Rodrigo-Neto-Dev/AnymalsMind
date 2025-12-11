if current_animal == "frog" and in_water == true {
	ysp = 0;
} else {
	ysp += 0.1
}
xsp = 0;

camera_set_view_pos(view_camera[0], x - (view_wport[0] / 2), y - (view_hport[0] / 2));

if keyboard_check_pressed(ord("P")) {
	room_goto(1)
}

// all variables that need to count down
if (transformation_cooldown > 0) {
	transformation_cooldown -= 1;
}

if (bird_jump_timer > 0) {
	bird_jump_timer -= 1;
}


// Transformation:
if (transformation_cooldown == 0) {
	if (keyboard_check_pressed(ord("1")) && (current_animal != "bird" )) {
		sprite_index = sP1Bird;
		transformation_cooldown = 120;
		current_animal = "bird";
	}
	if (keyboard_check_pressed(ord("2")) && (current_animal != "bear" )) {
		sprite_index = sP1Bear;
		transformation_cooldown = 120;
		current_animal = "bear";
	}
	if (keyboard_check_pressed(ord("3")) && (current_animal != "bear" )) {
		sprite_index = sPlayer; // sP1Frog
		transformation_cooldown = 120;
		current_animal = "dolphin";
	}
}


#region DOLPHIN WATER CHECK
    if place_meeting(x, y, oWater) {
	    _gravity = _gravity_swimming
		ysp = lerp(ysp, 0, 0.1)
		
		if !in_water {
			ysp /= 4
		}
		in_water = true
	} else {
		_gravity = _gravity_normal
	}
#endregion



if keyboard_check(vk_left) {
	xsp = -1;
}

if keyboard_check(vk_right) {
	xsp += 1;
}

if place_meeting(x, y+1, oSolid) {
	ysp = 0;
	is_grounded = true;
	bird_jumps = 3;
}

// codigo antigo que maybe é melhor idk

//if ( (keyboard_check(vk_up)) && ( (is_grounded == true) or (current_animal == "bird") ) ){
//	ysp = -2;
//	is_grounded = false;
//}

// actions player can only do when grounded

if ( keyboard_check_pressed(vk_up ) ) {
	if ( is_grounded == true ){
		ysp = -2;
		is_grounded = false;
	}
	else if ( (current_animal == "bird") && (bird_jump_timer == 0) && (bird_jumps > 0) ) {
		ysp = -2;
		bird_jump_timer += 10;
		bird_jumps--;
	}
	
}



move_and_collide(xsp, ysp, oSolid);

if place_meeting(x, y, oFlag) {
	room_goto_next();
}

if place_meeting(x, y, oSpike) {
	room_persistent = false
	room_restart();
}