
if (surface_exists(view_surf)) {
	surface_free(view_surf);
	view_surf = -1;
}

if (surface_exists(transition_bg_surf)) {
	surface_free(transition_bg_surf);
	transition_bg_surf = -1;
}
if (surface_exists(transition_mask_surf)) {
	surface_free(transition_mask_surf);
	transition_mask_surf = -1;
}
for(var i = 0; i < array_length(outline_surfaces); i++)
{
	if surface_exists(outline_surfaces[i]) surface_free(outline_surfaces[i]); 
}
