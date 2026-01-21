/// @description Global Variables

global.room_save = room
global.reset_all_rooms[1] = false

// UI
global.lives = 9;
global.current_level = 1;
global.animal_squares_selected = [false, false, false, false];

global.animals = ds_map_create();
ds_map_add(global.animals, "Human", {sprite: sPlayer, aerial: false, strong: false, aquatic: false, climber: false, discovered: true})

ds_map_add(global.animals, "Bird", {sprite: sP1Bird, aerial: true, strong: false, aquatic: false, climber: false, discovered: true})
ds_map_add(global.animals, "Bear", {sprite: sP1Bear, aerial: false, strong: true, aquatic: false, climber: false, discovered: true})
ds_map_add(global.animals, "Frog", {sprite: sP1Frog, aerial: false, strong: false, aquatic: true, climber: false, discovered: true})
ds_map_add(global.animals, "Cat", {sprite: sP1Cat, aerial: false, strong: false, aquatic: false, climber: true, discovered: true})

ds_map_add(global.animals, "Vulture", {sprite: sP1Vulture, aerial: true, strong: true, aquatic: false, climber: false, discovered: false})
ds_map_add(global.animals, "Griffon", {sprite: sP1Griffon, aerial: true, strong: false, aquatic: false, climber: true, discovered: false})

ds_map_add(global.animals, "Crab", {sprite: sP1Crab, aerial: false, strong: true, aquatic: true, climber: false, discovered: false})
ds_map_add(global.animals, "Panda", {sprite: sP1Panda, aerial: false, strong: true, aquatic: false, climber: true, discovered: false})

ds_map_add(global.animals, "Blobfish", {sprite: sP1Blob, aerial: false, strong: false, aquatic: true, climber: true, discovered: false})

// Just to print the inventory in order
global.animal_names = [
    "Human",
	"Bird",
	"Bear",
	"Frog",
	"Cat",
	"Vulture",
	"Griffon",
	"Crab",
	"Panda",
	"Blobfish"
]

global.current_animal = "Human"
global.current_animal_sprite = sPlayer
global.current_animation_states = ds_map_create();
ds_map_add(global.current_animation_states, "idle", sPlayerIdle);
ds_map_add(global.current_animation_states, "special", sPlayerSpecial);
ds_map_add(global.current_animation_states, "running", sPlayerRunning);
ds_map_add(global.current_animation_states, "jumping", sPlayerJumping);
ds_map_add(global.current_animation_states, "swimming", sPlayer);

persistent = true; 
