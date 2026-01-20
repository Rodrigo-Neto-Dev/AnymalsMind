if (other.carried_item != noone) {
	if (ds_list_size(inventory) < capacity) {

		// Store item ID
		ds_list_add(inventory, other.carried_item.item_id);

		// Destroy item instance
		instance_destroy(other.carried_item);

		// Clear Player 2 state
		other.carried_item = noone;
		other.state = "normal";
	}
}

