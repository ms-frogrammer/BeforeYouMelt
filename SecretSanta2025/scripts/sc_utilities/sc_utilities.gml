#macro foreach for(var _i = 0, ___list = 
#macro elem ; _i < ds_list_size(___list); _i++) { \
	var _elem = ___list[| _i]

#macro quit }


#region ARRAY / LIST
function grid_to_array(_grid){
	var grid_width = ds_grid_width(_grid);
	var grid_height = ds_grid_height(_grid);
	var saving_array = array_create(grid_width * grid_height);
	
	for (var i = 0; i < grid_width; i++)
	for (var j = 0; j < grid_height; j++) {
	    var idx = i + grid_width * j;
	    saving_array[idx] = _grid[# i, j];
	}
	return saving_array;
} 

function array_to_grid(_array, _w, _h) {
	var _grid = ds_grid_create(_w, _h);
	for (var i = 0; i < _w; i++)
	for (var j = 0; j < _h; j++) {
	    var idx = i + _w * j;
	    _grid[# i, j] = _array[idx];
	}
	return _grid;
}

function ds_list_to_array(_list) {
	var _size = ds_list_size(_list);
	var _array = array_create(_size);
	for(var i = 0; i < _size; i++) {
		_array[i] = _list[| i];
	}
	return _array;
}


function array_to_list(_array) {
	var _list = ds_list_create();
	for(var i = 0; i < array_length(_array); i++) {
		ds_list_add(_list, _array[i]);
	}
	return _list;
}

#endregion

#region LIST 
function ds_list_get_rand(_list) {
	return _list[| irandom(ds_list_size(_list) - 1)];
}

function ds_list_delete_value(_list, _value) {
	ds_list_delete(_list, ds_list_find_index(_list, _value));
}
#endregion

#region OTHER
function angle_360(_angle) {
	if _angle >= 360 return _angle - 360;
	else if _angle < 0 return _angle + 360;
	else return _angle;
}

function obj_get_anim_end() {
	var _spr_spd = sprite_get_speed(sprite_index);
	var _game_spd = game_get_speed(gamespeed_fps);
	var _fpgf = _spr_spd / _game_spd;

	//check if this is the last frame of the current sprite animation
	if (image_index >= image_number-_fpgf) {
		animation_end = true;	
	} else {
		animation_end = false;	
	}
}

function instance_is_ancestor(_inst, _obj) {
	return _inst.object_index == _obj || object_is_ancestor(_inst.object_index, _obj);
}

///@desc Move amount 'a' towards 'b' by the given amount
///@arg a
///@arg b
///@arg amount
function approach(__a, __b, __amount) {
	if (__a < __b) {
	    __a += __amount;
	    if (__a > __b) { return __b; }
	}
	else {
	    __a -= __amount;
	    if (__a < __b) { return __b; }
	}
	return __a;
}

///@desc Go between 2 values in a certain time
function wave(_from, _to, _dur, _offset) 
{
	var _a4 = (_to - _from) * 0.5;
	return _from + _a4 + sin((((current_time/1000) + _dur + _offset) / _dur) * (pi*2)) + _a4;
}

///@desc Add lengthdir to x and y
function move_to_dir(_spd, _dir) {
	x += lengthdir_x(_spd, _dir);
	y += lengthdir_y(_spd, _dir);
}

function chance(_chance) {
	return _chance>random(1);
}


#region FPS
global.__fps_avg = 0;
global.__fps_avg_total = 0;
global.__fps_avg_count = 0;

///@desc Draw the average fps
function draw_fps(_x, _y) {
	global.__fps_avg_total += fps_real;
	global.__fps_avg_count++;
	
	if (global.__fps_avg_count == 60) {
		global.__fps_avg = floor(global.__fps_avg_total/global.__fps_avg_count);
		global.__fps_avg_total = 0;
		global.__fps_avg_count = 0;
	}
	draw_text(_x, _y,string(global.__fps_avg) + " :  FPS");
}


///@desc Get average fps
function get_fps() {
	global.__fps_avg_total += fps_real;
	global.__fps_avg_count++;
	
	if (global.__fps_avg_count == 60) {
		global.__fps_avg = floor(global.__fps_avg_total/global.__fps_avg_count);
		global.__fps_avg_total = 0;
		global.__fps_avg_count = 0;
	}
	return global.__fps_avg;
}
#endregion


///@desc A placeholder function when you don't have one ready
function null_function() { return true; }
///@desc Like script_execute, but supports args given as an array
///@arg function - function to execute
///@arg args - array of arguments or singular arg
function function_execute(_function,_args) {
	if (is_array(_args)) {
		var _args_num = array_length(_args);
		switch (_args_num) {
			case 0: _function(); break;
			case 1: _function(_args[0]); break;
			case 2: _function(_args[0],_args[1]); break;
			case 3: _function(_args[0],_args[1],_args[2]); break;
			case 4: _function(_args[0],_args[1],_args[2],_args[3]); break;
			case 5: _function(_args[0],_args[1],_args[2],_args[3],_args[4]); break;
			case 6: _function(_args[0],_args[1],_args[2],_args[3],_args[4],_args[5]); break;
			case 7: _function(_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6]); break;
			case 8: _function(_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6],_args[7]); break;
			case 9: _function(_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6],_args[7],_args[8]); break;
			case 10: _function(_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6],_args[7],_args[8],_args[9]); break;
		}
	}
	else {
		_function(_args);	
	}
}

///@desc Default sorting formula for comparing values within custom sorting functions
function sort_compare(_a, _b) {
	return (_a > _b) ? 1 : ((_a < _b) ? -1 : 0);
}

///@desc Convert a string with percentage to a real decimal value, e.g. "64%" -> 0.64
///@arg percent - string with digits and percent sign
function percent_string_to_decimal(_percent) {
	_percent = real(string_digits(_percent));
	return _percent/100;
}

///@desc Convert a decimal value to a percentage string, e.g. 0.64 -> "64%"
///@arg decimal - real decimal value
function decimal_to_string_percent(_decimal) {
	return string_format(_decimal*100,1,0) + "%";
}

///@desc Remaps a value from one range to another
///@arg value
///@arg min_input
///@arg max_input
///@arg min_output
///@arg max_output
function remap(_value, _min_input, _max_input, _min_output, _max_output) {
	var _t = (_value - _min_input) / (_max_input - _min_input);
	return lerp(_min_output, _max_output, _t);
}

///@desc Wrap a value within a range (inclusive)
///@arg value
///@arg min
///@arg max
function wrap_value(_value,_min,_max) {
	if (_max < _min) { return _value; }
	if (_value > _max) {
		_value -= _min;
		_value = _value mod ((_max-_min)+1);
		_value += _min;
	}
	else if (_value < _min) {
		_value -= _min;
		var _range = (_max-_min)+1;
		_value = ((_value mod _range) + _range) mod _range;
		_value += _min;
	}
	return _value; 
}

///@desc Get name of keyboard check
///@arg key - key constant
function key_to_string(_key) { 
 
	switch(_key) {
		case vk_space:			return "SPACE";
		case vk_left:			return "LEFT";		
		case vk_right:			return "RIGHT";		
		case vk_up:				return "UP";
		case vk_down:			return "DOWN";	
		case vk_add:			return "+";
		case vk_alt:			return "ALT";
		case vk_backspace:		return "BACKSPACE";
		case vk_control:		return "CTRL";
		case vk_decimal:		return ".";
		case vk_delete:			return "DELETE";
		case vk_divide:			return "/";
		case vk_end:			return "END";
		case vk_enter:			return "ENTER";
		case vk_escape:			return "ESCAPE";
		case vk_f1:				return "F1";
		case vk_f2:				return "F2";
		case vk_f3:				return "F3";
		case vk_f4:				return "F4";
		case vk_f5:				return "F5";
		case vk_f6:				return "F6";
		case vk_f7:				return "F7";
		case vk_f8:				return "F8";
		case vk_f9:				return "F9";
		case vk_f10:			return "F10";
		case vk_f11:			return "F11";
		case vk_f12:			return "F12";
		case vk_home:			return "HOME";
		case vk_insert:			return "INSERT";
		case vk_lalt:			return "L.ALT";
		case vk_lcontrol:		return "L.CTRL";
		case vk_lshift:			return "L.SHIFT";
		case vk_multiply:		return "*";
		case vk_numpad0:		return "NUM 0";
		case vk_numpad1:		return "NUM 1";
		case vk_numpad2:		return "NUM 2";
		case vk_numpad3:		return "NUM 3";
		case vk_numpad4:		return "NUM 4";
		case vk_numpad5:		return "NUM 5";
		case vk_numpad6:		return "NUM 6";
		case vk_numpad7:		return "NUM 7";
		case vk_numpad8:		return "NUM 8";
		case vk_numpad9:		return "NUM 9";
		case vk_pagedown:		return "PAGE DOWN";
		case vk_pageup:			return "PAGE UP";
		case vk_pause:			return "PAUSE";
		case vk_printscreen:	return "PRT SCR";
		case vk_ralt:			return "R.ALT";
		case vk_rcontrol:		return "R.CTRL";
		case vk_rshift:			return "R.SHIFT";
		case vk_subtract:		return "-";
		case vk_tab:			return "TAB";
		case 22:				return "CAPS LOCK";
		case 91:				return "WIN KEY";	
		default:		return chr(string(_key));
	}
}

///@func choose_weighted(choice_1,weight_1,choice_2,weight_2...)
///@desc Choose randomly from list of choices according to each of their weights
function choose_weighted() {
    var _n = 0;
    for (var _i = 1; _i < argument_count; _i += 2) {
        if (argument[_i] <= 0) { continue; }
        _n += argument[_i];
    }
    
    _n = random(_n);
    for (var _i = 1; _i < argument_count; _i += 2) {
        if (argument[_i] <= 0) { continue; }
        _n -= argument[_i];
        if (_n < 0) { return argument[_i - 1]; }
    }
    
    return argument[0];
}
	
///@desc Convert buffer to string
function buffer_to_string(_buffer) {
	buffer_seek(_buffer,buffer_seek_start,0);
	var _bufferstring = buffer_read(_buffer,buffer_string);	
	return _bufferstring;
}
	
function in_range(_val,_min,_max) {
	return ((_val >= _min) && (_val <= _max));	
}

#endregion





