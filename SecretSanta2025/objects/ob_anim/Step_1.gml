
if !destroy_on_end {
	if lifetime <= 0 {
		instance_destroy()
	}
	else lifetime--;
}

if follow_parent && instance_exists(parent) {
	x = parent.x;
	y = parent.y;
}