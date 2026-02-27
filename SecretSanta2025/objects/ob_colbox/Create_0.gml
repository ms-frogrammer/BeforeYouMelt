parent = undefined;
xoffset = 0;
yoffset = 0;
destroy_on_anim = false;
follow_scale = true;
ignore = false;
depth = -99;

function check_collision(_with, _x = x, _y = y) {
	return place_meeting(_x, _y, _with);
}

function get_collision_id(_with, _x = x, _y = y) {
	return instance_place(_x, _y, _with);
}

function get_all_collision_id(_with, _x = x, _y = y) {
	var _list = ds_list_create();
	if instance_place_list(_x, _y, _with, _list, true) {
		return _list;
	}
	else return noone;
	
}