if (invuln > 0) {
    draw_set_alpha(0.5);
    draw_self();
    draw_set_alpha(1);
} else {
    draw_self();
}