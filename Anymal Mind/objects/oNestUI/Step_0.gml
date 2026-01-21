//if (!ui_open) exit;
//
//// click inventory
//if (mouse_check_button_pressed(mb_left)) {
//    var mx = device_mouse_x_to_gui(0);
//    var my = device_mouse_y_to_gui(0);
//
//    for (var i = 0; i < ds_list_size(active_nest.inventory); i++) {
//        var iy = 40 + i * 18;
//        if (mx > 40 && mx < 200 && my > iy && my < iy + 18) {
//            if (selected_item_a == -1) selected_item_a = i;
//            else if (selected_item_b == -1 && i != selected_item_a) selected_item_b = i;
//        }
//    }
//}
//
//// craft
//if (keyboard_check_pressed(vk_enter)) {
//    if (selected_item_a != -1 && selected_item_b != -1) {
//        var a = active_nest.inventory[| selected_item_a];
//        var b = active_nest.inventory[| selected_item_b];
//
//        var result = craft_items(a, b);
//
//        if (result != ITEM.NONE) {
//            var hi = max(selected_item_a, selected_item_b);
//            var lo = min(selected_item_a, selected_item_b);
//            ds_list_delete(active_nest.inventory, hi);
//            ds_list_delete(active_nest.inventory, lo);
//            ds_list_add(active_nest.inventory, result);
//        }
//
//        selected_item_a = -1;
//        selected_item_b = -1;
//    }
//}
//
if (!ui_open || ui_mode != "nest") exit;

if (keyboard_check_pressed(vk_escape)) {
    close();
    exit;
}

if (!instance_exists(active_nest)) { close(); exit; }
if (!variable_instance_exists(active_nest, "inventory")) { close(); exit; }

// mouse wheel scroll (GUI coords not required here)
var wheel = mouse_wheel_up() - mouse_wheel_down(); // up=1, down=-1 in recent GMS
// If your GMS returns opposite, swap signs.
if (wheel != 0) {
    // whichever side you're hovering will scroll
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    // panel geometry (must match Draw)
    var gw = display_get_gui_width();
    var gh = display_get_gui_height();
    var px = 40, py = 40, pw = gw - 80, ph = gh - 80;

    var content_y = py + title_h + pad;
    var content_h = ph - title_h - pad * 2;

    var col_gap = 16;
    var col_w = (pw - pad * 2 - col_gap) * 0.5;

    var inv_x = px + pad;
    var inv_y = content_y;

    var rec_x = px + pad + col_w + col_gap;
    var rec_y = content_y;

    var inv_rect = {x1: inv_x, y1: inv_y, x2: inv_x + col_w, y2: inv_y + content_h - 52};
    var rec_rect = {x1: rec_x, y1: rec_y, x2: rec_x + col_w, y2: rec_y + content_h - 52};

    var scroll_delta = -wheel * 3; // lines per wheel

    if (mx >= inv_rect.x1 && mx <= inv_rect.x2 && my >= inv_rect.y1 && my <= inv_rect.y2) inv_scroll += scroll_delta;
    if (mx >= rec_rect.x1 && mx <= rec_rect.x2 && my >= rec_rect.y1 && my <= rec_rect.y2) rec_scroll += scroll_delta;
}

// clamp scrolls
var inv_count = ds_list_size(active_nest.inventory);
inv_scroll = clamp(inv_scroll, 0, max(0, inv_count - 1));

var rec_count = array_length(recipes_keys);
rec_scroll = clamp(rec_scroll, 0, max(0, rec_count - 1));

