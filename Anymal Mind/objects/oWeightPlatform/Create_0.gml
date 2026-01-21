no_weight_y = y;

up_speed = 3;
down_speed = 1;

allowed_distance_to_activate_platform = 3;

function ascend() {
	if (y == no_weight_y) return;
	
	var dy = 0;
	if (y - up_speed < no_weight_y) dy = - (y - no_weight_y);
	else dy = -up_speed;
	
	move_and_collide(0, dy, get_obstacles());
}

function descend() {
	move_and_collide(0, down_speed, get_obstacles());
	
	// Make player move with the platform
	with (oPlayer) {
        if (place_meeting(x, y + 2, other)) {
            x += other.x - other.xprevious
            y += other.y - other.yprevious
        }
    }
}