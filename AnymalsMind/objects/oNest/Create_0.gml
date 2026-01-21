inventory = ds_list_create();
capacity = 10;

function has_space() {
    return ds_list_size(inventory) < capacity;
}

function deposit_item(item_id) {
    if (item_id == ITEM.NONE) return false;
    if (!has_space()) return false;
    ds_list_add(inventory, item_id);
    return true;
}

function withdraw_index(idx) {
    if (idx < 0 || idx >= ds_list_size(inventory)) return ITEM.NONE;
    var it = inventory[| idx];
    ds_list_delete(inventory, idx);
    return it;
}

// Optional test data
ds_list_add(inventory, ITEM.TWIG);
ds_list_add(inventory, ITEM.STONE);
ds_list_add(inventory, ITEM.FEATHER);

