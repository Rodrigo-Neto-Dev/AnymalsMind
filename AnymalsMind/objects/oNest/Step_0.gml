if (place_meeting(x, y, oP2) && keyboard_check_pressed(ord("E"))) {
    with (oNestUI) {
        open(id);
    }
}


function try_merge(item_a, item_b) {
	var key = item_a + "+" + item_b;
	if (recipes[? key] != undefined) {
		return recipes[? key];
	}
	return "";
}
