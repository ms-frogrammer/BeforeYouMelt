if keyboard_check_pressed(ord("P"))
{
    room_goto(rm_22);

    with ob_plr
    {
        x = room_width/2;
        y = room_height/2;
        restart();
    }
}