
function raycast(_x, _y, _angle, _length){
	var _collider_list = ds_list_create();
	for(var i = 4; i < argument_count; i++) {
		ds_list_add(_collider_list, argument[i]);
	}
	
	var _coords = array_create(0);

	for (var j = 0; j <= _length; j += 1){

	    var lx = clamp(_x + lengthdir_x(j, _angle), 0, room_width);
	    var ly = clamp(_y + lengthdir_y(j, _angle), 0, room_height);
		
		for(var i = 0; i < ds_list_size(_collider_list); i++){
			var collider = ds_list_find_value(_collider_list, i);
			var _instance = collision_point(floor(lx), floor(ly), collider, true, true);
			array_push(_coords, {x : lx, y : ly});
			
			 if(_instance)  {
				 
				var _hit_x = lx;
				var _hit_y = ly;
				return {
					x : _hit_x,
					y : _hit_y,
					id : _instance,
					coords : _coords,
				}
		    }
		}
	}
	return false;

}

function draw_raycast_coords(_coords, _color = c_white, _perc = 1, _rad = 0.5) {
	for(var i = 0; i <= array_length(coords) - _perc; i+=_perc) {
		draw_circle_color(_coords[i].x, _coords[i].y, _rad, _color, _color, false);
	}
}

function draw_raycast_line(_x, _y, _angle, _length, _color = c_white, _perc = 1, _rad = 0.5) {
	for (var j = 0; j <= _length - _perc; j += _perc){

	    var lx = clamp(_x + lengthdir_x(j, _angle), 0, room_width);
	    var ly = clamp(_y + lengthdir_y(j, _angle), 0, room_height);
		
		draw_circle_color(lx, ly, _rad, _color, _color, false);
	}
}