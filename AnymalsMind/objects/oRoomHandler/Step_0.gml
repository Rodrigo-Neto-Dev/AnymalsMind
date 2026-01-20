if (containsP1State(P1State.SWIMMING)) {
	set_background(water_back, water_back_color, water_music);
	
	if (!in_water) {
		set_water_alpha(water_transparent_alpha);
	}
	in_water = true;
} else {
	set_background(main_back, main_back_color, main_music);
	
	if (in_water) {
		set_water_alpha(water_opaque_alpha);
	}
	in_water = false;
}
