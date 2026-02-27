is_drawing_message = false;
interact_rad = 64;
talk_cooldown = 0
talk_cooldown_max = 60;

begin_talk = function()
{
    ob_dialogue_handler.begin_talk(id, is_on_bottom);
}

end_talk = function()
{
    talk_cooldown = talk_cooldown_max;
}