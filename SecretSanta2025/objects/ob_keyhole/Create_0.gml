door = noone;
is_unlocked = false;
is_key_sequence = false;
key_sequence_time = 0;
key_sequence_dur = 15;

set_door = function(_id)
{
	door = _id;
}
	
pop = function()
{
	instance_destroy();
}

unlock = function()
{
	is_unlocked = true;
	with door unlock_one();
}


return_data = function()
{
    var _vars = [
        "x",
        "y",
        "is_unlocked",
        "is_key_sequence",
    ];

    return save_vars(id, _vars);
}