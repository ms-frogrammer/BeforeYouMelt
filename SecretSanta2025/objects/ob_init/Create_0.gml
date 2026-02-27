log("Game initialized.");

instance_create_depth(0, 0, 0, ob_cam);
instance_create_depth(0, 0, 0, ob_dev);
instance_create_depth(0, 0, 0, ob_game);
instance_create_depth(0, 0, 0, ob_event_handler);


room_goto_next();

var _list = ds_list_create();
ds_list_add(_list, "frog", "rammer");

foreach _list elem
	log($"{_elem} is at {_i}!");
quit


