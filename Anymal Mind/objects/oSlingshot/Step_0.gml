event_inherited();
is_moving = 1;

if (fire_cooldown > 0) fire_cooldown--;

if (keyboard_check_pressed(trigger_key) && fire_cooldown <= 0) {
    fire_at_p2();
    fire_cooldown = fire_cooldown_max;
}