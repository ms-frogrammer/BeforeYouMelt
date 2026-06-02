//log($"wind size {array_length(particles)}");
for(var i = 0, wid = array_length(particles); i < wid; i++)
{
    if is_undefined(particles[i]) continue;
    move_particle(i);

    if global.is_windy 
        draw_particle(particles[i]);
}
