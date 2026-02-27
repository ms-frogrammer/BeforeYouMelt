if instance_exists(parent) {
	x  = parent.x + xoffset;
	y = parent.y + yoffset;
}

if blink_rate <= 0 {
	blink_rate = blink_rate_max;
	
	blink_number ++;
	blink_now = !blink_now;
	
	if blink_number > blink_number_max {
		instance_destroy();
	}
}
else blink_rate--;


x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16);