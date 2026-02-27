is_available = true;


text_id = HUT_1;
show_puddle = false;
puddle_beanie = true;

man_x = 364;
man_y = 286;
man_anim = new Anim(sp_man_idle);
show_man = false;
is_walking = false;
man_left_x = 208;
man_reached_beanie = false;
man_go_back = false;

show_title = false;
title_alpha = 0;
title_text = "Before You Melt";
small_title = false;
speedrun_title = false;
best_time_data = -1;
is_new_best = false;

back_to_menu = false;

start = function()
{
	// End the game
	global.game_ending = true;

	if global.is_speedrun_mode
	{
		save_speedrun(global.speedrun_clock);
		melt();
		speedrun_finish();
	}
	else 
	{
		call_later(2, time_source_units_seconds, load_dialogue);
	}

	is_available = false;
	global.plr_input_enabled = false;
	
	
	audio_stop_sound(music_main);
	audio_play_sound(music_bym_dialogue, 1, false);
}

load_dialogue = function()
{
	ob_dialogue_handler.begin_talk(id, false);
}

end_talk = function(){
	global.plr_input_enabled = false;

	call_later(2,  time_source_units_seconds, melt);
}

melt = function()
{
	global.is_windy = false;
	global.is_sunrise = false;
	with ob_snow_layer instance_destroy();

	show_puddle = true;

	with ob_block_par instance_destroy();
	instance_destroy(ob_plr);
	
	if !global.is_speedrun_mode
		call_later(4,  time_source_units_seconds, door);
}

door = function()
{
	image_index = 1;
	show_man = true;

	call_later(1,  time_source_units_seconds, walk);
}

walk = function()
{
	is_walking = true;
	man_anim.play(sp_man_transition, false);
}

reached_puddle = function()
{
	call_later(1,  time_source_units_seconds, pick_up_beanie);
}
pick_up_beanie = function()
{
	man_anim.play(sp_man_beanie_idle, false);
	puddle_beanie = false;
	call_later(2,  time_source_units_seconds, go_back);
}

go_back = function()
{
	man_go_back = true;
	man_anim.play(sp_man_beanie_walk, false);
}

finish = function()
{
	image_index = 0;
	show_man = false;

	call_later(2,  time_source_units_seconds, title);
}

speedrun_finish = function()
{
	image_index = 0;
	show_man = false;

	small_title = true;
	title_text = "";

	speedrun_title = true;
	best_time_data = load_speedrun();
	if best_time_data == global.speedrun_clock
	{
		is_new_best = true;
	}

	the_end();
}

title = function()
{
	if !show_title
	{
		show_title = true;
		call_later(4, time_source_units_seconds, game_by);
	}
	
}

game_by = function()
{
	small_title = true;
	title_text = "a game by frogrammer"
	call_later(4, time_source_units_seconds, special_thanks);
}

special_thanks = function()
{
	title_text = "special thanks to \n \n Daniel James Freer \n HumanIsRed";
	
	call_later(4, time_source_units_seconds, secret_santa);
}

secret_santa = function()
{
	title_text = "made for matt_ugh during Frogwell's Secret Santa";
	
	call_later(4, time_source_units_seconds, love_letter);
}

love_letter = function()
{
	title_text = "...and inspired by his games.";
	
	call_later(4, time_source_units_seconds, thank_you);
}

thank_you = function()
{
	title_text = "thank you for playing.";
	
	call_later(4, time_source_units_seconds, the_end);
}

the_end = function()
{
	title_text = "";
	back_to_menu = true;
}