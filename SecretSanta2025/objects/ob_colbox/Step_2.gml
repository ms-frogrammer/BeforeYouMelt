if !instance_exists(parent) {
	log_warn("Colbox has no parent! Auto-destroy.");
	instance_destroy();
	return;
}

x = parent.x + xoffset;
y = parent.y + yoffset;

if destroy_on_anim {
	
}
else if follow_scale {
	image_xscale = parent.image_xscale;
	image_yscale = parent.image_yscale;
	image_angle = parent.image_angle;
}
