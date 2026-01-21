if (peck_cooldown > 0) peck_cooldown--;

switch (state) {
	case "stunned":
		stun_timer--;
		if (stun_timer <= 0) state = "normal";
		exit;
		
	case "downed":
		// No movement or actions
		exit;
}


if (mouse_check_button_pressed(mb_right)) {
	if (state == "normal" && peck_cooldown <= 0) {
		var e = instance_nearest(x, y, oEnemy);
		if (e != noone && point_distance(x,y,e.x,e.y) <= peck_range) {
			with (e) other.peck_hit(id);
		}
		peck_cooldown = peck_cooldown_max;
	}
}

if (state == "normal" && carried_item == noone) {
	var itm = instance_place(x, y, oItem);
	if (itm != noone && mouse_check_button_pressed(mb_left)) {
		carried_item = itm;
		itm.visible = false;
		itm.active = false;
		state = "carrying";
	}
}

function drop_item() {
	if (carried_item != noone) {
		carried_item.x = x;
		carried_item.y = y;
		carried_item.visible = true;
		carried_item.active = true;
		carried_item = noone;
		state = "normal";
	}
}

function take_damage(amount) {
	if (state == "downed") return;

	hp -= amount;
	drop_item();

	if (hp <= 0) {
		state = "downed";
	} else {
		state = "stunned";
		stun_timer = 30;
	}
}

function revive() {
	hp = hp_max;
	state = "normal";
}

if (place_meeting(x, y, oNest) && mouse_check_button_pressed(mb_left)) {
    var n = instance_place(x, y, oNest);
    if (n != noone) {
        if (instance_exists(oNestUI)) {
            with (oNestUI) open(n.id);
        } else {
            var ui = instance_create_layer(0, 0, "UI", oNestUI);
            ui.open(n.id);
        }
    }
}

if (carried_item != noone && place_meeting(x, y, oNest) && mouse_check_button_pressed(mb_right)) {
    var n = instance_place(x, y, oNest);
    if (n != noone) {
        var id_to_deposit = carried_item.item_id;
        if (n.deposit_item(id_to_deposit)) {
            with (carried_item) instance_destroy(); // consume the world item
            carried_item = noone;
            state = "normal";
        }
    }
}

cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);
cam_w = camera_get_view_width(view_camera[0]);
cam_h = camera_get_view_height(view_camera[0]);

nx = x + clamp(mouse_x - x, -spd, spd);
ny = y + clamp(mouse_y - y, -spd, spd);

//if (!place_meeting(nx, y, oSolid)) 
x = nx;
//if (!place_meeting(x, ny, oSolid)) 
y = ny;

x = clamp(x, cam_x, cam_x + cam_w);
y = clamp(y, cam_y, cam_y + cam_h);

if (mouse_check_button_pressed(key_ui_interact())) {
	var square_selected_and_state = get_square_selected(x, y);
	var square_selected = square_selected_and_state[0];
	var square_state = square_selected_and_state[1];
	
	if (square_selected == -1 || 5 <= square_selected) return;
	if (0 <= square_selected and square_selected <= 3) select_animal(square_selected, square_state);
}
