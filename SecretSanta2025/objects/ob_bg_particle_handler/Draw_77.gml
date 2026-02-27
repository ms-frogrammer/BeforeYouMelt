for(var i = 0; i < array_length(particles_to_delete); i++)
{
    // Replace with a new one
    var _dir = wind_dir - 180;

    var _len = room_height/2 + spawn_margin;
    var _x1 = room_width + lengthdir_x(_len, _dir - 90);
    var _x2 = room_width + lengthdir_x(_len, _dir + 90);
    var _y1 = room_height/2 + lengthdir_y(_len, _dir - 90);
    var _y2 = room_height/2 + lengthdir_y(_len, _dir + 90);

    var _x = random_range(_x1, _x2) + spawn_xoff;
    var _y = random_range(_y1, _y2) + spawn_yoff;
    var _p = new_particle(BG_PARTICLES.SNOW, _x, _y, -2, 0, wind_dir + random_range(-dir_var/2, dir_var), wind_spd);

    _p.id = particles_to_delete[i];
    particles[_p.id] = _p;
}
particles_to_delete = [];