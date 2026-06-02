#macro GAME_SAVE working_directory + "before_you_melt.json"
#macro BEST_TIME working_directory + "best_time.json"



// Save function
function save_json(_data, _name) {
    var json_string = json_stringify(_data);
    var buffer = buffer_create(string_byte_length(json_string) + 1, buffer_fixed, 1);
    buffer_write(buffer, buffer_string, json_string);
    buffer_save(buffer, _name);
    buffer_delete(buffer);
}

// Load function
function load_json(_name) {
    var buffer = buffer_load(_name);
    if (buffer != -1) {
        var json_string = buffer_read(buffer, buffer_string);
        buffer_delete(buffer);
        return json_parse(json_string);
    }
    return undefined;
}   

function save_game()
{
    var _game_data = {};

    if global.at_room == undefined show_error("The last room is undefined. Cannot save the game...", true);
    else _game_data.room_name = room_get_name(global.at_room);

    save_json(_game_data, GAME_SAVE);
}

function load_game()
{
    var _game_data = -1;

    if file_exists(GAME_SAVE)
    {
        _game_data = load_json(GAME_SAVE);
    }
    
    return _game_data;
}


function save_speedrun(_clock)
{

    var _best_time = -1;
    if file_exists(BEST_TIME)
    {
        _best_time = load_json(BEST_TIME);
    }

    // Write new BEST time
    if global.speedrun_clock < _best_time || _best_time == -1
    {
        _best_time = global.speedrun_clock;
    }

    save_json(_best_time, BEST_TIME);
}

function load_speedrun()
{
    var _best_time = -1;
    if file_exists(BEST_TIME)
    {
        _best_time = load_json(BEST_TIME);
    }

    return _best_time;
}

function save_vars(_id, _var_names)
{
    var _variables = [];

    for(var i = 0, wid = array_length(_var_names); i < wid; i++)
    {
        var _val = variable_instance_get(_id, _var_names[i])
        array_push(_variables, _var_names[i]);
        array_push(_variables, deep_copy(_val)); 
    }

    return _variables;

}

function clear_room_info()
{
    global.room_info = [];
}

function update_room_data()
{
    var _info = {};
    
    _info.objects = [];
    _info.variables = [];
    
    var _objects = SAVE_OBJECTS;
    for(var i = 0; i < array_length(_objects); i++)
    {
        var _obj = _objects[i];
        for(var j = 0; j < instance_number(_obj); j++)
        {
            var _inst = instance_find(_obj, j);
            var _data = _inst.return_data();
            
            array_push(_info.objects,    _inst.object_index);
            array_push(_info.variables,  _data);
        }
    }

    array_push(global.room_info, _info);    
}

function load_room_data()
{
    
    // Make sure there's data, otherwise restart the room
    var _no_data = array_length(global.room_info) == 0;
    if _no_data 
    {
        ob_room_handler.reload_room();
        exit;
    }

    // Get the last info
    var _info = array_last(global.room_info);

    global.plr_id = noone;

    // - Destroy all current objects to reload
    var _objects = SAVE_OBJECTS;
    for(var i = 0; i < array_length(_objects); i++)
    {
        with _objects[i] instance_destroy();
    }

    // Refill all ice storages for now
    with ob_ice_storage refill();

    for(i = 0; i < array_length(_info.objects); i++)
    {
        var _obj = _info.objects[i];
        var _vars = _info.variables[i];

        with instance_create_layer(0, 0, "Instances", _obj)
        {
            for(var j = 0, wid = array_length(_vars); j < wid; j+=2)
            {
                variable_instance_set(id, _vars[j], _vars[j + 1]);
            }

            // // If an ice block is placed, let it's storage know it's used
            if _obj == ob_ice 
            {
                with storage_id take();
            }
        }
    } 

    // - Remove ice that's currently used from ice storage 
        var _storages_used = ob_plr.storage_ids;
        for(var k = 0; k < array_length(_storages_used); k++)
        {
            with _storages_used[k] take();
        }
    // -

    // Remove this entry
    array_pop(global.room_info);
}