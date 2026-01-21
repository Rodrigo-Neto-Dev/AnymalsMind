if (!place_meeting(x, y - allowed_distance_to_activate_platform, oPlayer)) {
	ascend();
	return;
}

if (get_player_current_animal() != "Blobfish") {
	ascend();
	return;
}

if (!containsP1State(P1State.GROUNDED)) {
	ascend();
	return;
}

descend();