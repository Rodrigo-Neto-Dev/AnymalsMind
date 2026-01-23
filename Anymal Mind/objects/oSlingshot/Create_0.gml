event_inherited();

damage_to_p1 = 1;
damage_to_p2 = 1;
damage_to_enemy = 2;
damage_to_boss = 1;

bullet_speed = 12;          
fire_cooldown_max = 20;     
fire_cooldown = irandom(fire_cooldown_max);

trigger_key = ord("F");

function fire_at_p2() {
    var p2 = instance_find(oP2, 0);
    if (p2 == noone) return;

    var dir = point_direction(x, y, p2.x, p2.y);

    var b = instance_create_layer(x, y, "PlayersEnemies", oBullet);
    b.direction = dir;
    b.speed = bullet_speed;

    // pass damage values into the bullet
    b.damage_to_p1 = damage_to_p1;
    b.damage_to_p2 = damage_to_p2;
    b.damage_to_enemy = damage_to_enemy;
    b.damage_to_boss = damage_to_boss;
}