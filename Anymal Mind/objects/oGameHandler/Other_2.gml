/// @description Global Variables

global.room_save = room
global.reset_all_rooms[1] = false

global.lives = 9;
global.current_level = 1;

global.animals = ds_map_create();
ds_map_add(global.animals, "Human", {sprite: sPlayer, aerial: false, aquatic: false, climber: false, discovered: true})
ds_map_add(global.animals, "Bird", {sprite: sP1Bird, aerial: true, aquatic: false, climber: false, discovered: true})
ds_map_add(global.animals, "Bear", {sprite: sP1Bear, aerial: false, aquatic: false, climber: false, discovered: true})
ds_map_add(global.animals, "Frog", {sprite: sP1Frog, aerial: false, aquatic: true, climber: false, discovered: true})
ds_map_add(global.animals, "Cat", {sprite: sP1Cat, aerial: false, aquatic: false, climber: true, discovered: true})
ds_map_add(global.animals, "Griffon", {sprite: sP1Griffon, aerial: true, aquatic: false, climber: true, discovered: false})

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
