var p1 = instance_nearest(x, y, oPlayer);
if (distance_to_object(p1) < 12) {
	p1.take_damage(contact_damage);
}
	
function take_damage(amount) {
	hp -= amount;
	if (hp <= 0) {
		instance_create_layer(x, y, "Enemies", oItem); // drop
		instance_destroy();
	}
}


function peck_hit(attacker) {
	take_damage(1);
}