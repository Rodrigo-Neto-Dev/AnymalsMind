/// @description Global Variables

global.room_save = room
global.reset_all_rooms[1] = false

global.animals = ds_map_create();
ds_map_add(global.animals, "Human", {aerial: false, aquatic: false, climber: false, discovered: false})
ds_map_add(global.animals, "Bird", {aerial: true, aquatic: false, climber: false, discovered: false})
ds_map_add(global.animals, "Bear", {aerial: false, aquatic: false, climber: false, discovered: false})
ds_map_add(global.animals, "Frog", {aerial: false, aquatic: true, climber: false, discovered: false})
ds_map_add(global.animals, "Cat", {aerial: false, aquatic: false, climber: true, discovered: false})
ds_map_add(global.animals, "Griffon", {aerial: true, aquatic: false, climber: true, discovered: false})

// Just to print the inventory in order
global.animal_names = [
    "Human",
	"Bird",
	"Bear",
	"Frog",
	"Cat",
	"Griffon"
]

global.current_animal = "Human"
global.current_animal_sprite = sPlayer
global.current_animation_states = ds_map_create();
ds_map_add(global.current_animation_states, "idle", sPlayer);
ds_map_add(global.current_animation_states, "special", sPlayer);
ds_map_add(global.current_animation_states, "running", sPlayer);
ds_map_add(global.current_animation_states, "jumping", sPlayer);
ds_map_add(global.current_animation_states, "swimming", sPlayer);

persistent = true; 
