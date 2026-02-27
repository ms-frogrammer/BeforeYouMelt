if time != -1 {
	if time > 0 time -= 1;
	else instance_destroy();
}

if stay_on_index != -1 image_index = stay_on_index;
else image_speed = 1;

if move_in_dir {
	vel_x = lengthdir_x(spd, dir);
	vel_y = lengthdir_y(spd, dir);
	spd += clamp(-spd, -decell, decell);
}
else {
	vel_x += clamp(-vel_x, -decell, decell);
	vel_y += clamp(-vel_y, -decell, decell);
}

x += vel_x;
y += vel_y;

if angle_to_vel image_angle = point_direction(0, 0, vel_x, vel_y);
if set_angle != -1 image_angle = set_angle;
image_angle += angle_spd;

image_alpha -= fade_spd;
if image_alpha <= 0 instance_destroy();

scale_x += scale_spd_x;
scale_y += scale_spd_y;
image_xscale = scale_x;
image_yscale = scale_y;

if destroy_on_scale {
	if scale_x <= 0 instance_destroy();
	if scale_y <= 0 instance_destroy();
}

//depth = -y/2 - 1;
