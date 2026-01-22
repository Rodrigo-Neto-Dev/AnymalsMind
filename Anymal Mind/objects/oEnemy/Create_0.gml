hp_max = 4;
hp = hp_max;

invuln = 0;          // frames of invulnerability after hit
invuln_max = 0;


contact_damage = 1;  // damage to P2 on touch
contact_cooldown = 0;
contact_cooldown_max = 20;

// Optional: on-death drops (ITEM ids)
drops = [oJumper]; // e.g. drops = [ITEM.TWIG, ITEM.STONE];

function take_damage(amount) {
    if (invuln > 0) return;

    hp -= amount;
    show_debug_message("ENEMY " + string(id) + " took " + string(amount) + " hp=" + string(hp));

    invuln = invuln_max;

    if (hp <= 0) die();
}


function die() {
    for (var i = 0; i < array_length(drops); i++) {
        var it = instance_create_layer(x, y, "Enemies", oJumper);
        it.item_id = drops[i];
    }
    instance_destroy();
}