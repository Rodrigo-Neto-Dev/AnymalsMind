if (invuln > 0) invuln--;
if (contact_cooldown > 0) contact_cooldown--;

if (contact_cooldown <= 0) {
    var p2 = instance_place(x, y, oP2);
    if (p2 != noone && p2.state != "downed") {

        if (variable_instance_exists(p2, "take_damage")) {
            p2.take_damage(contact_damage);
            contact_cooldown = contact_cooldown_max;
        } else {
            // If this happens, your oP2 Create still isn't defining it.
            // Do nothing to avoid crashing.
        }
    }
}