if (!ui_open || ui_mode != "nest") exit;
if (!instance_exists(active_nest)) exit;
if (!variable_instance_exists(active_nest, "inventory")) exit;
if (!variable_global_exists("recipes")) exit;
if (!ds_exists(global.recipes, ds_type_map)) exit;


draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(fUI);
var gw = display_get_gui_width();
var gh = display_get_gui_height();
draw_rectangle(0, 0, gw, gh, false);

var px = 40;
var py = 40;
var pw = gw - 80;
var ph = gh - 80;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var click = mouse_check_button_pressed(mb_left);

// backdrop
draw_set_alpha(0.55);
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);
draw_set_alpha(1);

// panel
draw_set_color(make_color_rgb(20, 20, 24));
draw_rectangle(px, py, px + pw, py + ph, false);

// border
draw_set_color(make_color_rgb(90, 90, 110));
draw_rectangle(px, py, px + pw, py + ph, true);

// title bar
draw_set_color(make_color_rgb(35, 35, 45));
draw_rectangle(px, py, px + pw, py + title_h, false);

draw_set_color(c_white);
draw_set_font(fUI);
draw_text(px + pad, py + 6, "NEST — Inventory & Crafting");

// close button (top right)
var cx2 = px + pw - pad;
var cx1 = cx2 - 18;
var cy1 = py + 6;
var cy2 = cy1 + 18;

var close_hover = (mx >= cx1 && mx <= cx2 && my >= cy1 && my <= cy2);
draw_set_color(close_hover ? c_red : make_color_rgb(160, 160, 180));
draw_rectangle(cx1, cy1, cx2, cy2, true);
draw_text(cx1 + 5, cy1 + 1, "X");
if (click && close_hover) { close(); exit; }

// layout
var content_y = py + title_h + pad;
var content_h = ph - title_h - pad * 2;

var col_gap = 16;
var col_w = (pw - pad * 2 - col_gap) * 0.5;

var inv_x = px + pad;
var rec_x = px + pad + col_w + col_gap;
var col_y = content_y;

// list areas (leave space at bottom for craft area)
var list_h = content_h - 52;

var inv_rect_x1 = inv_x;
var inv_rect_y1 = col_y + 18;
var inv_rect_x2 = inv_x + col_w;
var inv_rect_y2 = inv_rect_y1 + list_h;

var rec_rect_x1 = rec_x;
var rec_rect_y1 = col_y + 18;
var rec_rect_x2 = rec_x + col_w;
var rec_rect_y2 = rec_rect_y1 + list_h;

// headers
draw_set_color(make_color_rgb(200, 200, 220));
draw_text(inv_x, col_y, "Inventory");
draw_text(rec_x, col_y, "Known Recipes");

// column backgrounds
draw_set_color(make_color_rgb(26, 26, 32));
draw_rectangle(inv_rect_x1, inv_rect_y1, inv_rect_x2, inv_rect_y2, false);
draw_rectangle(rec_rect_x1, rec_rect_y1, rec_rect_x2, rec_rect_y2, false);

draw_set_color(make_color_rgb(70, 70, 90));
draw_rectangle(inv_rect_x1, inv_rect_y1, inv_rect_x2, inv_rect_y2, true);
draw_rectangle(rec_rect_x1, rec_rect_y1, rec_rect_x2, rec_rect_y2, true);

// visible rows
var rows_visible = floor((list_h) / row_h);

// -----------------------
// Inventory list + clicks
// -----------------------
var inv_count = ds_list_size(active_nest.inventory);
inv_scroll = clamp(inv_scroll, 0, max(0, inv_count - rows_visible));

var inv_hover_index = -1;

for (var r = 0; r < rows_visible; r++) {
    var i = inv_scroll + r;
    if (i >= inv_count) break;

    var yy = inv_rect_y1 + r * row_h;	

    var hover = (mx >= inv_rect_x1 && mx <= inv_rect_x2 && my >= yy && my < yy + row_h);
    if (hover) inv_hover_index = i;

    var selected = (i == selected_item_a || i == selected_item_b);

    if (selected) {
        draw_set_color(make_color_rgb(60, 110, 60));
        draw_rectangle(inv_rect_x1 + 1, yy, inv_rect_x2 - 1, yy + row_h, false);
    } else if (hover) {
        draw_set_color(make_color_rgb(50, 50, 70));
        draw_rectangle(inv_rect_x1 + 1, yy, inv_rect_x2 - 1, yy + row_h, false);
    }

    var item_id = active_nest.inventory[| i];
    var name = global.item_names[item_id];

    draw_set_color(c_white);
    draw_text(inv_rect_x1 + 8, yy + 3, name);
}

if (click && inv_hover_index != -1) {
    // pick A then B, click selected again to unselect
    if (selected_item_a == inv_hover_index) selected_item_a = -1;
    else if (selected_item_b == inv_hover_index) selected_item_b = -1;
    else if (selected_item_a == -1) selected_item_a = inv_hover_index;
    else if (selected_item_b == -1) selected_item_b = inv_hover_index;
    else {
        // replace A if both full
        selected_item_a = inv_hover_index;
        selected_item_b = -1;
    }
}

// -----------------------
// Recipes list
// -----------------------
var rec_count = array_length(recipes_keys);
rec_scroll = clamp(rec_scroll, 0, max(0, rec_count - rows_visible));

for (var r = 0; r < rows_visible; r++) {
    var j = rec_scroll + r;
    if (j >= rec_count) break;

     var yy = rec_rect_y1 + r * row_h;

    var hover = (mx >= rec_rect_x1 && mx <= rec_rect_x2 && my >= yy && my < yy + row_h);
    if (hover) {
        draw_set_color(make_color_rgb(50, 50, 70));
        draw_rectangle(rec_rect_x1 + 1, yy, rec_rect_x2 - 1, yy + row_h, false);
    }

    var key = recipes_keys[j];
    var result_item = global.recipes[? key];

    // key format "a_b"
    var p = string_pos("_", key);
    var a = real(string_copy(key, 1, p - 1));
    var b = real(string_copy(key, p + 1, string_length(key) - p));

    var text =
        global.item_names[a] + " + " +
        global.item_names[b] + " → " +
        global.item_names[result_item];

    draw_set_color(make_color_rgb(230, 230, 240));
    draw_text(rec_rect_x1 + 8, yy + 3, text);
}

// -----------------------
// Craft area
// -----------------------
var footer_y = py + ph - pad - 28;

var a_ok = (selected_item_a != -1 && selected_item_a < ds_list_size(active_nest.inventory));
var b_ok = (selected_item_b != -1 && selected_item_b < ds_list_size(active_nest.inventory));

var a_item = a_ok ? active_nest.inventory[| selected_item_a] : ITEM.NONE;
var b_item = b_ok ? active_nest.inventory[| selected_item_b] : ITEM.NONE;

var result = (a_ok && b_ok) ? craft_items(a_item, b_item) : ITEM.NONE;
var can_craft = (result != ITEM.NONE);

// selected summary (left)
draw_set_color(make_color_rgb(200,200,220));
var summary =
    "Selected: " +
    (a_ok ? global.item_names[a_item] : "—") +
    " + " +
    (b_ok ? global.item_names[b_item] : "—") +
    "   Result: " +
    (can_craft ? global.item_names[result] : "—");

draw_text(px + pad, footer_y + 4, summary);

// craft button (right)
var bw = 140;
var bh = 26;
var bx = px + pw - pad - bw;
var by = footer_y;

var craft_hover = (mx >= bx && mx <= bx + bw && my >= by && my <= by + bh);

if (!can_craft) {
    draw_set_color(make_color_rgb(70, 70, 80));
} else if (craft_hover) {
    draw_set_color(make_color_rgb(90, 160, 90));
} else {
    draw_set_color(make_color_rgb(70, 130, 70));
}
draw_rectangle(bx, by, bx + bw, by + bh, false);

draw_set_color(make_color_rgb(40, 40, 50));
draw_rectangle(bx, by, bx + bw, by + bh, true);

draw_set_color(c_white);
draw_text(bx + 10, by + 5, "CRAFT");

// craft click
if (click && craft_hover && can_craft) {
    // remove higher index first
    var hi = max(selected_item_a, selected_item_b);
    var lo = min(selected_item_a, selected_item_b);

    ds_list_delete(active_nest.inventory, hi);
    ds_list_delete(active_nest.inventory, lo);
    ds_list_add(active_nest.inventory, result);

    selected_item_a = -1;
    selected_item_b = -1;
}