life--;
if (life <= 0) { instance_destroy(); exit; }

x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);

// Hit everything in a radius (including multiple enemies)
var hit_list = ds_list_create();
collision_circle_list(x, y, hit_radius, all, false, true, hit_list, true);

for (var i = 0; i < ds_list_size(hit_list); i++) {
    var t = hit_list[| i];

    // Only damage these types:
    if (!(t.object_index == oPlayer || t.object_index == oP2 || t.object_index == oEnemy || t.object_index == oEnemyFlyer )) {
        continue;
    }

    // Prevent multi-hit every frame on same target
    var key = string(t.id);
    var now = current_time;
    var last = ds_map_exists(hit_cd, key) ? hit_cd[? key] : -999999;
    if (now - last < 80) continue; // ~0.08s
    hit_cd[? key] = now;

    // Damage routing
    if (t.object_index == oP2) {
        t.take_damage(damage_to_p2);
    } else if (t.object_index == oPlayer) {
        if (variable_instance_exists(t, "take_damage")) t.take_damage(damage_to_p1);
        else t.die();
    } else {
        // enemy of any child type if parented correctly
        if (variable_instance_exists(t, "take_damage")) t.take_damage(damage_to_enemy);
        else if (variable_instance_exists(t, "hp")) {
            t.hp -= damage_to_enemy;
            if (t.hp <= 0 && variable_instance_exists(t, "die")) t.die();
        }
    }

    if (!pierce) { ds_list_destroy(hit_list); instance_destroy(); exit; }
}

ds_list_destroy(hit_list);