/// @description Room Global Variables

global.room_save = room;

background = layer_background_get_id(layer_get_id("Background"));
current_music = sndMain;

main_back = sBack;
main_back_color = #28FF33;
main_music = sndMain;

water_back = sBackWater;
water_back_color = -1;
water_music = sndWater;
in_water = false;
water_transparent_alpha = 0.2;
water_opaque_alpha = 1;

prepare_background_music();

function prepare_background_music() {
	audio_stop_all();
	
	// Start playing
	audio_play_sound(main_music, 10, true);
	audio_play_sound(water_music, 10, true);
	
	// Pause all but the current music
	audio_pause_all();
	audio_resume_sound(current_music);
}

function set_background(back, back_color, music) {
	layer_background_change(background, back);
	layer_background_blend(background, back_color);
	if (current_music != music) {
	    audio_pause_sound(current_music);
		audio_resume_sound(music);
	    current_music = music;
	}
}

function set_water_alpha(alpha) {
	with (oWater) {
		show_debug_message(alpha);
	    image_alpha = alpha;
	}
}