hp_max = 3;
hp = hp_max;

invuln = 0;          // frames of invulnerability after hit
invuln_max = 10;

knockback = 3;       // pixels pushed on peck

contact_damage = 1;  // damage to P2 on touch
contact_cooldown = 0;
contact_cooldown_max = 20;

// Optional: on-death drops (ITEM ids)
drops = []; // e.g. drops = [ITEM.TWIG, ITEM.STONE];

function peck_hit(attacker_id) {
    if (invuln > 0) return;

    hp -= 1;
    invuln = invuln_max;

    // knock away from attacker
    if (instance_exists(attacker_id)) {
        var dir = point_direction(attacker_id.x, attacker_id.y, x, y);
        x += lengthdir_x(knockback, dir);
        y += lengthdir_y(knockback, dir);
    }

    if (hp <= 0) die();
}

function die() {
    // Drop as world items (requires oItem with item_id field)
    for (var i = 0; i < array_length(drops); i++) {
        var it = instance_create_layer(x, y, "Instances", oItem);
        it.item_id = drops[i];
    }
    instance_destroy();
}