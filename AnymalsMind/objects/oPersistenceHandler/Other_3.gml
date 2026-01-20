clear_selected_animals();

for (var i = 0; i < room_last; i++) {
	room_goto_next()
	room_persistent = false
}
global.reset_all_rooms[0] = true
room_goto(2)