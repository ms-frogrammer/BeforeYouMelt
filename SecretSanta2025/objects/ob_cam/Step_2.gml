//if (live_call()) exit;
// keep the actual camera at integer coordinates:
camera_set_view_pos(VIEW, x + shake.x, y + shake.y);

application_surface_enable(false);
camera_set_view_size(VIEW, game_width, game_height);
	
// [re-]create the surface if needed
if (!surface_exists(view_surf)) {
	view_surf = surface_create(game_width, game_height);
}
view_surface_id[0] = view_surf;

for(var i = 0; i < array_length(outline_surfaces); i++)
{
	if (!surface_exists(outline_surfaces[i])) {
		outline_surfaces[i] = surface_create(game_width + 1, game_height + 1);
	}
}

if (!surface_exists(transition_bg_surf)) {
	transition_bg_surf = surface_create(game_width, game_height);
}

if (!surface_exists(transition_mask_surf)) {
	transition_mask_surf = surface_create(game_width, game_height);
}
shake.step();