function discover_animal(name){
	for (var i = 0; i < array_length(global.animals); i++) {
		if (global.animals[i].name == name) {
			global.animals[i].discovered = true;
			break;
		}
	}
}