has_signal = false;

set_signal = function(_open)
{
	has_signal = _open;
}

if !skip_create
{
	skip_create = true;
	height = image_yscale * sprite_get_height(sprite_index);
	top = bbox_top - height;
	bottom = bbox_bottom - height;

	block = instance_create_layer(x, bbox_bottom, layer, ob_col);
	block.image_yscale = image_yscale;
}

spd = 2;
snd = -1;

return_data = function()
{
    var _vars = [
        "x",
        "y",
		"height",
		"top",
		"bottom",
		"opposite",
		"has_signal",
		"image_xscale",
		"image_yscale",
		"block",
		"skip_create",
    ];

    return save_vars(id, _vars);
}