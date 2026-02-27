function screen_shake(_duration, _strength) {
	if !instance_exists(ob_cam) exit;
	
	ob_cam.shake.shake(_duration, _strength);
}

