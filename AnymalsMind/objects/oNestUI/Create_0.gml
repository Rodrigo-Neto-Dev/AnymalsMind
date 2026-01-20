ui_open = false;
ui_mode = "none"; // none | nest
active_nest = noone;

// Inventory selection
selected_item_a = -1;
selected_item_b = -1;

persistent = true;

// scrolling
inv_scroll = 0;
rec_scroll = 0;

// cached recipe keys (array of keys) to display consistently
recipes_keys = [];

// layout tuning
pad = 16;
row_h = 22;
title_h = 28;

function open(nest_inst) {
    ui_open = true;
    ui_mode = "nest";
    active_nest = nest_inst;
    selected_item_a = -1;
    selected_item_b = -1;
    inv_scroll = 0;
    rec_scroll = 0;

    // cache keys for stable ordering
    recipes_keys = [];
    if (variable_global_exists("recipes") && ds_exists(global.recipes, ds_type_map)) {
        var k = ds_map_find_first(global.recipes);
        while (!is_undefined(k)) {
            array_push(recipes_keys, k);
            k = ds_map_find_next(global.recipes, k);
        }
        // optional: sort keys alphabetically (stable visual)
        array_sort(recipes_keys, true);
    }
}

function close() {
    ui_open = false;
    ui_mode = "none";
    active_nest = noone;
    selected_item_a = -1;
    selected_item_b = -1;
}

