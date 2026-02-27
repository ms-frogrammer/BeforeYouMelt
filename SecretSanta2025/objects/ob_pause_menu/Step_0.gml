var _move = input_check_opposing_pressed("up", "down");
var _press = input_check_pressed("accept");

if _move > 0 
{
	selected++;
	snd_play_rndpitch(sfx_jump_1);
}
else if _move < 0 
{	
	selected--;
	snd_play_rndpitch(sfx_jump_1);
}

if is_message selected = wrap_value(selected, 0, 1);
else selected = wrap_value(selected, 0, array_length(btn_funcs)-1);

if _press
{
	input_verb_consume("jump");
	
	if is_message {
		if (selected == 0) 
			message_yes()
		else 
			message_no();
	}
	else btn_funcs[selected]();
	
	snd_play_rndpitch(sfx_talk_blip_1);
}