
// Go through all global events
for (var k = ds_map_find_first(global.global_event_map); !is_undefined(k); k = ds_map_find_next(global.global_event_map, k)) {
    // Count down events that have limited life duration
    if global.global_event_map[? k].lifetime != infinity {
      if global.global_event_map[? k].lifetime <= 0 {
          global.global_event_map[? k].die();
      }
      else global.global_event_map[? k].lifetime--;
    }
}