

if !point_in_rectangle(ob_plr.x, ob_plr.y, 0, 0, room_width, room_height) {
	global.plr_to_exit_x = x - ob_plr.x;
	global.plr_to_exit_y = y - ob_plr.y;
	if bbox_right > room_width global.plr_exit_dir = 0;
	else if bbox_left < 0 global.plr_exit_dir = 2;
	else if bbox_top < 0 global.plr_exit_dir = 1;
	else if bbox_bottom > room_height global.plr_exit_dir = 3;
	ob_room_handler.transition_to(to_room, exit_id)
}
