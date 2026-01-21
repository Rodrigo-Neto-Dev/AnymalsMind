if (instance_exists(oNestUI)) {
    with (oNestUI) open(other.id);
} else {
    var ui = instance_create_layer(0, 0, "UI", oNestUI);
    ui.open(other.id);
}