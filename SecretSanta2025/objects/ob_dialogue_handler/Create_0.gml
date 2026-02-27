current_talk_inst = noone;

begin_talk = function(_talk_inst, _is_on_bottom)
{
    if global.is_dialogue_on exit;
    global.is_dialogue_on = true;

    current_talk_inst = _talk_inst;
	
    global.dialogue_is_on_bottom = _is_on_bottom;
    textbox_create(_talk_inst.text_id);

    global.plr_input_enabled = false;
}

end_talk = function()
{
    global.is_dialogue_on = false;
    global.plr_input_enabled = true;
    with current_talk_inst end_talk();
    
}

rtrn_can_talk = function()
{
	return true;
}
event_subscribe(EV_TEXTBOX_END, end_talk);