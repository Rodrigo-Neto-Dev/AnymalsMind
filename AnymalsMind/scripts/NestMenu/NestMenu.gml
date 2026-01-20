function open(nest_inst) {
ui_open = true;
ui_mode = "nest";
active_nest = nest_inst;
selected_item_a = -1;
selected_item_b = -1;
}


function close() {
ui_open = false;
ui_mode = "none";
active_nest = noone;
}