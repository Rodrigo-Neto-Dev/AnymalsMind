if (ui_show_animals) {
    // Semi-transparent or non-transparent dark background
    draw_set_color(c_black);
    draw_set_alpha(0.70);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);

    // Title
    draw_set_color(c_white);
	var title = "Transformations:"
	var title_width = string_width(title);
	var title_height = string_height(title);
    text(title, title_width / 2, 20 + title_height / 2, fn30, fa_center, fa_center, c_white, 1);

    // List entries
	var xx = 0;
    var yy = 20 + 1.5 * title_height;
	var entry_height = 0;
	
    for (var i = 0; i < array_length(global.animal_names); i++) {
		var name = global.animal_names[i];
		var a = global.animals[? name];

        if (a.discovered) {
			xx = string_width(name);
			entry_height = string_height(name);
            text(name, xx / 2, yy + entry_height / 2, fn30, fa_center, fa_center, c_lime, 1);
        } else {
			xx = string_width("???");
			entry_height = string_height("???");
            text("???", xx / 2, yy + entry_height / 2, fn30, fa_center, fa_center, c_orange, 1);
        }

        yy += entry_height - 15;
    }
}
