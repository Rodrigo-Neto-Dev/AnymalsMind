width = display_get_gui_width();
height = display_get_gui_height();

rectangle_width = width;
rectangle_height = height / 8;
top_rectangle_color = c_grey;
bottom_rectangle_color = c_grey;
bottom_rect_yorigin = height - rectangle_height;

// Top
text_xscale = 5;
text_yscale = 5;

// Lives
lives_color = c_aqua;
lives_icon = sElephantIcon;

// Level
level_color = c_aqua;

// Bottom
square_side_length = width / 10;
square_outline_color = c_black;

// Animals
first_unmerged_animal_index = 1;
last_unmerged_animal_index = 4;
animal_background_color = c_lime;
animal_scale = 4;

// Items
item_background_color = c_silver;