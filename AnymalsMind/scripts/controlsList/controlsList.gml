// Player 1

open_pause_menu = ord("P");
open_inventory = ord("B");

up = vk_up;
down = vk_down;
left = vk_left;
right = vk_right;
up_wasd = ord("W");
down_wasd = ord("S");
left_wasd = ord("A");
right_wasd = ord("D");

dash = ord("E");

// Player 2

ui_interact = mb_left;

function key_open_pause_menu() {
	return global.open_pause_menu;
}

function key_open_inventory() {
	return global.open_inventory;
}

function key_up() {
	return global.up;
}

function key_down() {
	return global.down;
}

function key_left() {
	return global.left;
}

function key_right() {
	return global.right;
}

function key_up_wasd() {
	return global.up_wasd;
}

function key_down_wasd() {
	return global.down_wasd;
}

function key_left_wasd() {
	return global.left_wasd;
}

function key_right_wasd() {
	return global.right_wasd;
}

function key_dash() {
	return global.dash;
}

function key_ui_interact() {
	return global.ui_interact;
}