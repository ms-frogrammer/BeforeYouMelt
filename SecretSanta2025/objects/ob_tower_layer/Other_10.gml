if !layer_exists("Tower") instance_destroy();

var _tower_layer = layer_get_id("Tower");

layer_set_visible(_tower_layer, false);

draw_tilemap(layer_tilemap_get_id(_tower_layer), - camera_get_view_x(VIEW), - camera_get_view_y(VIEW));