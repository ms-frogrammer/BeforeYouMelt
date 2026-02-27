if !skip_create
{
    skip_create = true;
    image_yscale = round(image_yscale);
    colliders = [];
    for(var i = 0; i < image_yscale; i++)
    {
        var _collider = instance_create_layer(x, bbox_bottom - i * 16, layer, ob_col);
        array_push(colliders, _collider);
    }
}

keyholes = [];
alarm[0] = 1;

is_unlocked = false;
unlocked_number = 0;
myshake = new Shake();

is_popping = false;
pop_time = 0;
pop_dur = 30;

unlocked_all = function()
{
	if !is_unlocked call_later(60, time_source_units_frames, open);
	myshake.shake(5, 60);
    is_unlocked = true;
}

open = function()
{
	for(var i = 0; i < array_length(keyholes); i++)
    {
        keyholes[i].pop();
    }

    for(var i = 0; i < image_yscale; i++)
    {
        vfx_create_cloud(x, bbox_bottom - i * 16, sp_effect_circle, WHITE, 4, 1, 2, 0.05, -30, 0.5, 0.75, -1/30, 30, false, 1/120);
    }

    instance_destroy();
}
unlock_one = function()
{
    myshake.shake(2, 10);
    unlocked_number++;

    // Save game
    update_room_data();

    if unlocked_number >= array_length(keyholes)
    {
        unlocked_all();
    }
}


return_data = function()
{
    var _vars = [
        "x",
        "y",
        "image_xscale",
        "image_yscale",
        "is_unlocked",
        "unlocked_number",
        "is_popping",
        "colliders",
        "skip_create"
    ];

    return save_vars(id, _vars);
}

