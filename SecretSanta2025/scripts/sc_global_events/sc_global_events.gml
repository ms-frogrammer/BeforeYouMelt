#macro EVENTS_GLOBAL_WARN_ABOUT_SAME_NAME false // Should the system throw out a warning message every time an event with an already existing name is added?

global.global_event_map = ds_map_create();

function EventGlobal(_name, _lifetime = infinity) constructor {
    name = _name;
    lifetime = _lifetime;
    data = {};
	
    pass_data = function(_data) {
        data = _data;
    }
	
    get_data = function() {
       return data;
    }
       
    // Warn about an event with the same name.
    if EVENTS_GLOBAL_WARN_ABOUT_SAME_NAME
        if ds_map_exists(global.global_event_map, name) {
            // Delete the previous event with this name.
            global.global_event_map[? name].die();
            log_warn("Global Event '" + name + "' already exists. All good?", noone);
        }
		
    // Write this event into the map.
    global.global_event_map[? name] = self;
    

     die = function() {
        //mdm(name + " has died.", noone);
        ds_map_delete(global.global_event_map, name);
    }
   
}

function event_global_listen(_name) {
    if ds_map_exists(global.global_event_map, _name) return global.global_event_map[? _name];
    else return undefined;
}