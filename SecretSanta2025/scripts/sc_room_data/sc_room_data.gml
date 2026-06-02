global.room_order = ds_list_create();

function RoomData(_is_night, _is_windy, _has_bird, _is_sunrise, _bg_track = undefined) constructor {
	is_night = _is_night;
	is_windy = _is_windy;
	has_bird = _has_bird;
	is_sunrise = _is_sunrise;
	bg_track = _bg_track;
}

function rm_data(_rm, _is_night, _is_windy, _has_bird, _is_sunrise, _bg_track = undefined) {
	
	global.room_data[? room_get_name(_rm)] = new RoomData(_is_night, _is_windy, _has_bird, _is_sunrise, _bg_track);
	ds_list_add(global.room_order, _rm);

}
global.room_data = ds_map_create();

// Day, Windy, No bird, Not sunrise
rm_data(rm_1, false, true, false, false);
rm_data(rm_2, false, true, false, false, music_main);
rm_data(rm_3, false, true, false, false, music_main);
rm_data(rm_4, false, true, false, false, music_main);
rm_data(rm_5, false, true, false, false, music_main);
rm_data(rm_6A, false, true, false, false, music_main);
rm_data(rm_6B, false, true, false, false, music_main);
rm_data(rm_7, false, true, false, false, music_main);
rm_data(rm_8, false, true, false, false, music_main);
rm_data(rm_9, false, true, false, false, music_main);
rm_data(rm_10, false, true, false, false, music_main);
rm_data(rm_11, false, true, false, false);

// Night, Not Windy, No bird, Not sunrise
rm_data(rm_12, true, false, false, false, music_bym_dialogue);
rm_data(rm_13, true, false, false, false, music_bym_dialogue);

// Night, Not wWindy, Bird, Not sunrise
rm_data(rm_14, true, false, true, false, music_bym_dialogue);

// Night, Windy, Bird, Not sunrise
rm_data(rm_15, true, true, true, false, music_main_slowed);
rm_data(rm_16, true, true, true, false, music_main_slowed);
rm_data(rm_17, true, true, true, false, music_main_slowed);
rm_data(rm_18, true, true, true, false, music_main_slowed);
rm_data(rm_19, true, true, true, false, music_main_slowed);
rm_data(rm_20, true, true, true, false, music_main_slowed);

// Not night, Windy, Bird, Sunrise
rm_data(rm_21, false, true, true, true);
rm_data(rm_22, false, true, true, true);
rm_data(rm_final, false, true, true, true);