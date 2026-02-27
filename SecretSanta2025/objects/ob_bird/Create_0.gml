
cling_to_plr = function()
{
	global.has_bird = true;
	with ob_talk instance_destroy();
	instance_destroy();
}

alarm[0] = 1;


event_subscribe(EV_TEXTBOX_END, cling_to_plr);