#macro TILE 16
#macro TILE_COLLISION_LAYER_NAME "Tile_Collisions"
#macro TILE_BG_LAYER_NAME "Background"
#macro TILE_DEFAULT_TILEMAP_NAME "Tiles_1"

function tile_generate_col_map(_room_w, _room_h, _tile_size, _tilemap_name) {
	var _w = ceil(_room_w/_tile_size);
	var _h = ceil(_room_h/_tile_size);
	var _map = ds_grid_create(_w, _h);

	// Create the layer for collider instances
	var _layer = layer_create(-999, TILE_COLLISION_LAYER_NAME);
	var _bg_layer_id = -1;
	if layer_exists(TILE_BG_LAYER_NAME) 
	{
		_bg_layer_id = layer_get_id(TILE_BG_LAYER_NAME);
		// Place the tile collision layer 1 unit above the background
		layer_depth(_layer, layer_get_depth(_bg_layer_id) - 1);
	}
	
	
	var _tilemap_id = -1;
	
	if layer_exists(_tilemap_name)
	{
		_tilemap_id = layer_get_id(_tilemap_name);
	}
	else 
	{
		log_warn("No tilemap layer with name '" + _tilemap_name + "' was found.");
		
		return;
	}
	
	
	var _map_id = layer_tilemap_get_id(_tilemap_id);
	
	// Generate the map data based on where the tiles are placedS 
	for(var _x = 0; _x < _w; _x++)
	{
		for(var _y = 0; _y < _h; _y++)
		{

			var _tile_data = tilemap_get_at_pixel(_map_id, _x * TILE, _y * TILE) & tile_index_mask;
			if _tile_data != 0 {
				_map[# _x, _y] = 1;
			}
			else {
				_map[# _x, _y] = 0;
			}
		}
	}
	
	layer_set_visible(_tilemap_id, false);
	
	for(var _x = 0; _x <= _w; _x += 1) {
		for(var _y = 0; _y <= _h; _y += 1) {
			if _map[# _x, _y] {
				var _tile = instance_create_layer(_x * TILE + 8, _y * TILE + 16, _layer, ob_col);
			}
		}
	}

	layer_set_visible(_tilemap_id, true);
	layer_set_visible(_layer, false);

	return _map;
}

