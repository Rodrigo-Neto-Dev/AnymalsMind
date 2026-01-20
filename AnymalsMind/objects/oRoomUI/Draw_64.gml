draw_set_alpha(rectangle_alpha);
draw_rectangle_colour(0, 0, rectangle_width, rectangle_height, top_rectangle_color, top_rectangle_color, top_rectangle_color, top_rectangle_color, false);
draw_set_alpha(1);

draw_lives();
draw_current_level();


draw_set_alpha(rectangle_alpha);
draw_rectangle_colour(0, bottom_rect_yorigin, rectangle_width, height, bottom_rectangle_color, bottom_rectangle_color, bottom_rectangle_color, bottom_rectangle_color, false);
draw_set_alpha(1);

draw_animals();
draw_items();
