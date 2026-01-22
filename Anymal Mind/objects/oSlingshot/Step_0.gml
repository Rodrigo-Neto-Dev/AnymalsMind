event_inherited();
is_moving = 1;

if (fire_cooldown > 0) fire_cooldown--;

if (keyboard_check_pressed(trigger_key) && fire_cooldown <= 0) {
    fire_at_p2();
    fire_cooldown = fire_cooldown_max;
}
function fire_at_p2() {
    var p2 = instance_find(oP2, 0);
    if (p2 == noone) return;

    var dir = point_direction(x, y, p2.x, p2.y);

    var b = instance_create_layer(x, y, "Enemies", oBullet);
    b.direction = dir;
    b.speed = bullet_speed;

    // pass damage values into the bullet
    b.damage_to_p1 = damage_to_p1;
    b.damage_to_p2 = damage_to_p2;
    b.damage_to_enemy = damage_to_enemy;
    b.damage_to_boss = damage_to_boss;

}