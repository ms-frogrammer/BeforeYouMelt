
has_signal = false;

set_signal = function(_open)
{
	has_signal = _open;
}

if !skip_create 
{
	skip_create = true;
	width = image_xscale * sprite_get_height(sprite_index);
	if flip 
	{
		left = bbox_left;
		right = bbox_right;
	}
	else 
	{
		left = bbox_left - width;
		right = bbox_right - width;
	}

	block = instance_create_layer(x + width/2, y + 8, layer, ob_col);
	block.image_xscale = image_xscale;
}

spd = 2;
snd = -1;

return_data = function()
{
    var _vars = [
        "x",
        "y",
		"width",
		"right",
		"left",
		"opposite",
		"flip",
		"image_xscale",
		"image_yscale",
		"block",
		"has_signal",
		"skip_create",
    ];

    return save_vars(id, _vars);
}