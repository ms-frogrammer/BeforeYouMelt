log("Game initialized.");

instance_create_depth(0, 0, 0, ob_cam);
instance_create_depth(0, 0, 0, ob_dev);
instance_create_depth(0, 0, 0, ob_game);
instance_create_depth(0, 0, 0, ob_event_handler);

room_goto(rm_menu);
