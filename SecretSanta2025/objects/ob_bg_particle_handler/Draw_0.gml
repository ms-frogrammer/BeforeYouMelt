
if draw_spawn
{
    draw_set_color(c_purple);
    draw_text(25, 25, string(array_length(particles)));

    var _dir = wind_dir - 180
    var _x1 = room_width + lengthdir_x(room_height/2, _dir - 90);
    var _x2 = room_width + lengthdir_x(room_height/2, _dir + 90);
    var _y1 = room_height/2 + lengthdir_y(room_height/2, _dir - 90);
    var _y2 = room_height/2 + lengthdir_y(room_height/2, _dir + 90);

    draw_line(_x1 + spawn_xoff, _y1 + spawn_yoff, _x2 + spawn_xoff, _y2 + spawn_yoff);
}
draw_set_color(c_white);