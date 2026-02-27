//ds_debug_callstack = true;

#macro log my_debug_message
#macro log_split my_debug_message_split
#macro log_warn my_debug_warning
#macro log_list my_debug_list

function my_debug_message(_txt, _called_id = id) {
	var _caller_name = "Undefined";
	if _called_id != noone _caller_name = object_get_name(_called_id.object_index) + " [" + string(_called_id) + "]";
	
	if !is_string(_txt) _txt = string(_txt);
	show_debug_message(_txt + "		(" + _caller_name + ")");

}
function my_debug_message_split(_called_id = id) {
	var _caller_name = "Undefined";
	if _called_id != noone _caller_name = object_get_name(_called_id.object_index) + " [" + string(_called_id) + "]";
	
	var _whole_str = "";
	for(var i = 1; i < argument_count; i++) {
		var _txt = argument[i];
		if !is_string(_txt) _txt = string(_txt);
		_whole_str += _txt + " ";
	}

	show_debug_message(_whole_str + "		(" + _caller_name + ")");
}


function my_debug_warning(_txt, _called_id = id) {
	show_debug_message("----- WARNING! -----");
	my_debug_message(_txt, _called_id);
}


function my_debug_list(_list, _list_name = "list") {
	show_debug_message("debugging " + _list_name);
	foreach _list elem 
		show_debug_message(string(_elem));
	end
	
}

