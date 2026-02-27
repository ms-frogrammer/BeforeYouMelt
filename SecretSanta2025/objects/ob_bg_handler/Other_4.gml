if layer_exists("Background")
{
	depth = layer_get_depth(layer_get_id("Background")) + 1;
	layer_set_visible(layer_get_id("Background"), false);

}
