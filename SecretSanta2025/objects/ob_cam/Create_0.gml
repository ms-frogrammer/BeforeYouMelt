depth = -999;

#macro VIEW view_camera[0]

// this will be target game resolution:
game_width = RES_W;
game_height = RES_H;


// shake
shake = new Shake();

// following
follow_target = true;
target = ob_plr;

smooth = true;
view_surf = -1;

snap_to_target = function()
{
	if follow_target {
		if instance_exists(target) {
			x = target.x - game_width/2;
			x = clamp(x, 0, room_width - game_width);
			y = target.y - game_height/2;
			y = clamp(y, 0, room_height - game_height);
		}
	}
}
// dragging variables:
dragging_enabled = false;
dragging = false;
drag_x = 0;
drag_y = 0;

// outline
outline_surfaces = [];

outline_colors = [
	RED,  // 0
	DARK, // 1
	DARK, // 2
	WHITE // 3
];

outline_groups = [
	// 0
	[
		[ob_block_par, 1],
	],
	//1
	[
		[ob_hut, 0],
		[ob_tower_layer, 0],
		[ob_snow_layer, 0],
		[ob_spike, 0],
		[ob_semisolid, 0],
		[ob_ice_storage, 0],
		[ob_push_button, 0],
		[ob_slide_door, 0],
		[ob_slide_door_hor, 0],
		[ob_block_par, 0],
		[ob_door, 0],
		[ob_keyhole, 0],
		[ob_stark, 0],
		[ob_snowman_unhappy, 0],
		[ob_plr, 0],
		[ob_kart, 0],
		[ob_campfire, 0],
	],
	//2
	[
		[ob_hut, 1],
		[ob_particle, 0],
		[ob_anim, 0],
		[ob_plr, 1],
		[ob_interact_handler, 0],
		[ob_textbox, 0],
		[ob_room_handler, 0],
		[ob_pause_menu, 0],
		[ob_menu, 0],
		[ob_speedrun_menu, 0],
	],
];


for(var i = 0; i < array_length(outline_groups); i++)
{
	var _surf = surface_create(game_width, game_height);
    array_push(outline_surfaces, _surf);
}

// transition
transition_bg_surf = -1;
transition_mask_surf = -1;