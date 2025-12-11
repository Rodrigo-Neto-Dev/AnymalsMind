draw_set_color(c_white);
draw_rectangle(icon_x, icon_y, icon_x + icon_size, icon_y + icon_size, false);
draw_text(icon_x + 8, icon_y + 8, "B"); // or draw an icon

if (ui_show_animals) {
    // Semi-transparent or non-transparent dark background
    draw_set_color(c_black);
    draw_set_alpha(0.70); // adjust to taste
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);

    // Title
    draw_set_color(c_white);
    draw_text(24, 24, "Transformations:");

    // List entries
    var yy = 60;
    for (var i = 0; i < array_length(global.animals); i++) {
        var a = global.animals[i];

        if (a.discovered) {
            draw_set_color(c_lime);
            draw_text(40, yy, a.name);
        } else {
            draw_set_color(c_orange);
            draw_text(40, yy, "???");
        }

        yy += 28;
    }
}
