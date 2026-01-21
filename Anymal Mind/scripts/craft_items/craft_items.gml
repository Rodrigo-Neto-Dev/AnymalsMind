function craft_items(item_a, item_b) {
    if (!variable_global_exists("recipes")) return ITEM.NONE;
    if (!ds_exists(global.recipes, ds_type_map)) return ITEM.NONE;

    var key = recipe_key(item_a, item_b);
    if (ds_map_exists(global.recipes, key)) return global.recipes[? key];
    return ITEM.NONE;
}