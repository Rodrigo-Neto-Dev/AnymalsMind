function discover_animal(name) {
	for (var i = 0; i < array_length(global.animal_names); i++) {
		if (global.animal_names[i] == name) {
			global.animals[? name].discovered = true;
			break;
		}
	}
}