// Stores all the selected animal strings from the Room UI
selected_animals = [];

function get_selected_animals() {
    return global.selected_animals;
}

function add_animal_selected(animal) {
	var animals = get_selected_animals();
	
	if (!contains_animal_selected(animal) && array_length(animals) < 2) {
		array_push(animals, animal);
	}
}

function del_animal_selected(animal) {
	var animals = get_selected_animals();
	for (var i = 0; i < array_length(animals); i++) {
		if (animal == animals[i]) {
			array_delete(animals, i, 1);
		}
	}
}

function contains_animal_selected(animal) {
	return array_contains(get_selected_animals(), animal);
}

function get_player_current_animal() {
	var bird = contains_animal_selected("Bird");
	var bear = contains_animal_selected("Bear");
	var frog = contains_animal_selected("Frog");
	var cat = contains_animal_selected("Cat");
	
	if (bird) {
		if (bear) return "Human";
		if (frog) return "Human";
		if (cat) return "Griffon";
		return "Bird";
	}
	if (bear) {
		if (frog) return "Human";
		if (cat) return "Human";
		return "Bear";
	}
	if (frog) {
		if (cat) return "Human";
		return "Frog";
	}
	if (cat) {
		return "Cat";
	}
	return "Human";
}

function clear_selected_animals() {
	global.selected_animals = [];
}

function to_string_animals_selected() {
	var animals = get_selected_animals();
	
	var animals_string = "[";
	
	if (array_length(animals) != 0) {
		animals_string += animals[0];
	}
	
	for (var i = 1; i < array_length(animals); i++) {
		animals_string += ", ";
		animals_string += animals[i];
	}
	
	animals_string += "]";
	
	return animals_string;
}
