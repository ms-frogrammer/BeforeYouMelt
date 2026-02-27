for(var i = 0, wid = array_length(particles); i < wid; i++)
{
    if particles[i] == undefined continue;
    move_particle(i);

    if global.is_windy 
        draw_particle(particles[i]);
}
