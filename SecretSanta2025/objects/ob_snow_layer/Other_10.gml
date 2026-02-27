
if !layer_exists("Tiles_2") exit;

var _snow_layer = layer_get_id("Tiles_2");
layer_set_visible(_snow_layer, false);

draw_tilemap(layer_tilemap_get_id(_snow_layer), - camera_get_view_x(VIEW), - camera_get_view_y(VIEW)); 