
// Store all keyholes of this door
    var _holes = ds_list_create();
    instance_place_list(x, y, ob_keyhole, _holes, false);
    foreach _holes elem
        _elem.set_door(id);
        array_push(keyholes, _elem);
    end

    ds_list_destroy(_holes);