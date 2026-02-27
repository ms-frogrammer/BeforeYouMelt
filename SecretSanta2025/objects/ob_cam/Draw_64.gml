
// if smooth camera is enabled, draw the view surface
// at a fractional offset between desired camera position and integer one
var cx = camera_get_view_x(VIEW);
var cy = camera_get_view_y(VIEW);
var ax = camera_get_view_x(VIEW) - x - shake.x;
var ay = camera_get_view_y(VIEW) - y - shake.y;

for(var i = 0; i < array_length(outline_groups); i++)
{
	var _target_surf = outline_surfaces[i];
	if surface_exists(_target_surf)
	{	
		surface_set_target(_target_surf);

			// Clean the surface
			draw_clear_alpha(c_black, 0);
			
			for(var j = 0; j < array_length(outline_groups[i]); j++)
			{
				var _event = outline_groups[i][j][1];
				with outline_groups[i][j][0] event_user(_event);
			}

		surface_reset_target();

		surface_set_target(view_surf);
			//outline_draw_surface(_new_surf, ax, ay);
			
			var _color = outline_colors[i];
			outline_draw_surface_ext(_target_surf, 0, 0, 1, 1, 0, c_white, 1, ol_config(1, _color, 1, true, 0));

		surface_reset_target();
	}
	else continue;
}

#region TRANSITION

	// - TRANSITION VARIABLES
		var _t = AnimcurveTween(0, 1, acLinear, (1-global.transition_fade))	

		var _cx = RES_W/2;
		var _cy = RES_H/2;
		var _px = instance_exists(ob_plr) ? ob_plr.x : _cx;
		var _py = instance_exists(ob_plr) ? (ob_plr.y - ob_plr.count_parts()/2 * 16) : _cy;
	// -

	// - TRANSITION SURFACES
		if global.transition_fade > 0
		{
			// - BG
				if surface_exists(transition_bg_surf) 
				{
					surface_set_target(transition_bg_surf);
						var _bg_color = global.is_night ? #1D0F2B : ROCK;

						draw_set_color(_bg_color);
						draw_rectangle(cx, cy, game_width, game_height, false);
					surface_reset_target();
				}
			// -

			// - MASK
				if surface_exists(transition_mask_surf)
				{
					surface_set_target(transition_mask_surf);
						shader_set(sh_dither);

							draw_set_color(c_white);
							draw_clear_alpha(c_black, 0);
							//draw_circle(RES_W/2, RES_H/2, 64, false);
						
							draw_graident_cirlce(_px - cx, _py - cy, 900 * _t, c_white, c_white, 1, _t + 0.33, ceil(16 * _t) + 2);
							
						shader_reset();
					surface_reset_target();
				}
			// -
		}
	// -
#endregion

// Draw a few other things on top 
surface_set_target(view_surf);
	with ob_plr draw_arms();
	with ob_room_handler.front event_user(0);
	
	// Draw night filter
	if global.is_night 
	{
		draw_set_color(#100c37);
		draw_set_alpha(0.05);
			draw_rectangle(0, 0, game_width, game_height, false);
		draw_set_alpha(1);
		draw_set_color(c_white);
	}

	//with ob_textbox event_user(0);
surface_reset_target();


if (surface_exists(view_surf)) {
	
	// Transition effect
	if global.transition_fade > 0
	{
		if surface_exists(transition_bg_surf) && surface_exists(transition_mask_surf)
		{
			shader_set(sh_mask);
				texture_set_stage(shader_get_sampler_index(sh_mask, "mask"), surface_get_texture(transition_mask_surf));
				texture_set_stage(shader_get_sampler_index(sh_mask, "bg"), surface_get_texture(transition_bg_surf));

				// Draw the game through the mask effect
				draw_surface(view_surf, 0, 0);
				
			shader_reset();
		}
	}	
	else draw_surface(view_surf, 0, 0);
}


surface_set_target(view_surf);
draw_clear_alpha(c_black, 0);
surface_reset_target();

// for(var i = 0; i < array_length(_outline_surfs); i++)
// {
// 	surface_free(_outline_surfs[i]);
// }