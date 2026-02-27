global.registered_events = {};

function events_clear_all() 
{
    global.registered_events = {};
}

function event_subscribe(_event_name, _callback)
{
    // Get or create the callbacks array once
    var _exists = variable_struct_exists(global.registered_events, _event_name);
    if (!_exists) variable_struct_set(global.registered_events, _event_name, []);

    var _callbacks = variable_struct_get(global.registered_events, _event_name);
    array_push(_callbacks, _callback); // push by reference; no second set needed
}


function event_unsubscribe(_event_name, _callback)
{
    if (!variable_struct_exists(global.registered_events, _event_name)) return;

    var _callbacks = variable_struct_get(global.registered_events, _event_name);

    // Reverse to avoid index shifts
    for (var i = array_length(_callbacks) - 1; i >= 0; i--)
    {
        if (_callbacks[i] == _callback)
        {
            array_delete(_callbacks, i, 1);
        }
    }

    if (array_length(_callbacks) == 0)
    {
        variable_struct_remove(global.registered_events, _event_name);
    }
}


function event_publish(_event_name, _context = {}) 
{
	 if (!variable_struct_exists(global.registered_events, _event_name)) return;

    var _callbacks = variable_struct_get(global.registered_events, _event_name);
    var _len = array_length(_callbacks);
    if (_len == 0) { variable_struct_remove(global.registered_events, _event_name); return; }

    // Iterate over a shallow copy so in-callback mutations don’t affect iteration
    var _snapshot = array_create(_len);
    array_copy(_snapshot, 0, _callbacks, 0, _len);

    for (var i = 0; i < _len; i++)
    {
        var _cb = _snapshot[i];
        if (_cb != undefined) _cb(_context);
    }
}