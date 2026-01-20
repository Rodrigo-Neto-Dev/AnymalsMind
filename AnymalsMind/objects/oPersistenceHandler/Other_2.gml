audio_stop_all();

if global.reset_all_rooms[0] {
	for (var i = 2; i < room_last; i++) {
		room_persistent = true
	    room_goto_next()
    }
	room_goto(0)
}