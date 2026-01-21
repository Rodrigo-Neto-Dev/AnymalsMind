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
ds_map_add(global.animals, "Stingray", {sprite: sP1Stingray, aerial: true, strong: false, aquatic: true, climber: false, discovered: false})
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
	"Stingray",
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


// P2 states
global.p2_hits_to_knock = 3;
global.p2_stunned = false;
global.p2_stun_timer = 0;
global.p2_downed = false; // Can't move, awaits P1 rescue

// Item enums for easy merging (add more as needed)
enum ITEM {
    NONE = -1,
    TWIG,
    STONE,
    BERRY,
    LEAF,
    FLOWER,
    NUT,
    FEATHER,
    VINE,

    // Crafted
    SLING,
    GUST_POTION,
    BOUNCY_GLIDER,
    GRAPPLE_HOOK,
    FIRE_PECK,
    SHIELD_BUBBLE,
    ARMORED_SLING
}

// -----------------
// Item display names
// -----------------
global.item_names = array_create(100, "");
global.item_names[ITEM.TWIG]           = "Twig";
global.item_names[ITEM.STONE]          = "Stone";
global.item_names[ITEM.BERRY]          = "Berry";
global.item_names[ITEM.LEAF]           = "Leaf";
global.item_names[ITEM.FLOWER]         = "Flower";
global.item_names[ITEM.NUT]            = "Nut";
global.item_names[ITEM.FEATHER]        = "Feather";
global.item_names[ITEM.VINE]           = "Vine";
global.item_names[ITEM.SLING]          = "Sling";
global.item_names[ITEM.GUST_POTION]    = "Gust Potion";
global.item_names[ITEM.BOUNCY_GLIDER]  = "Bouncy Glider";
global.item_names[ITEM.GRAPPLE_HOOK]   = "Grapple Hook";
global.item_names[ITEM.FIRE_PECK]      = "Fire Peck";
global.item_names[ITEM.SHIELD_BUBBLE]  = "Shield Bubble";
global.item_names[ITEM.ARMORED_SLING]  = "Armored Sling";
// -----------------
// Recipes
// -----------------
global.recipes = ds_map_create();

// helper
function recipe_key(a, b) {
    return string(min(a,b)) + "_" + string(max(a,b));
}

// setup
ds_map_add(global.recipes, recipe_key(ITEM.TWIG, ITEM.STONE), ITEM.SLING);
ds_map_add(global.recipes, recipe_key(ITEM.BERRY, ITEM.FLOWER), ITEM.GUST_POTION);
ds_map_add(global.recipes, recipe_key(ITEM.LEAF, ITEM.NUT), ITEM.BOUNCY_GLIDER);
ds_map_add(global.recipes, recipe_key(ITEM.STONE, ITEM.VINE), ITEM.GRAPPLE_HOOK);
ds_map_add(global.recipes, recipe_key(ITEM.BERRY, ITEM.FEATHER), ITEM.FIRE_PECK);
ds_map_add(global.recipes, recipe_key(ITEM.FLOWER, ITEM.LEAF), ITEM.SHIELD_BUBBLE);

function craft_items(item_a, item_b) {
    if (!variable_global_exists("recipes")) return ITEM.NONE;
    if (!ds_exists(global.recipes, ds_type_map)) return ITEM.NONE;

    var key = recipe_key(item_a, item_b);
    if (ds_map_exists(global.recipes, key)) return global.recipes[? key];
    return ITEM.NONE;
}

persistent = true; 
