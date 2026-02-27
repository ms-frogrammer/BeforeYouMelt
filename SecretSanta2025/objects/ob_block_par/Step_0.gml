
// Enable collider by default
collider_on = true;


if is_falling
{
	vsp += grav;

	var _block = collision_rectangle(x - 8, y - 4, x + 8, y + vsp, [ob_col, ob_semisolid, ob_block_par], false, true);
	
    if _block 
    {
        stick_to(dir, _block);
    }

    y += vsp;
}
else 
{
	// Become unstable
	var _fall = false;
	
    if !instance_exists(stuck_block)
    {
       _fall = true;
    }
	else 
	{
		if object_is_ancestor(stuck_block.object_index, ob_block_par) || stuck_block.object_index == ob_block_par
		{
			if stuck_block.is_falling _fall = true;
		}
		if stuck_block.object_index == ob_col 
		{
			if stuck_block.is_sliding _fall = true;
		}
		
	}
	
	if _fall
	{
		is_falling = true;
	    dir = 270;
	    vsp = 0;
		collider_on = false;
	}
	else 
	{
		// Force grabbing this block if the player got stuck
		// if place_meeting(x, y, ob_plr)
		// {
		// 	log("Stuck grab");
		// 	ob_plr.grab_block = id;
		// 	ob_plr.grab();
		// }
	}
	
	myshake.step();
}

if lifetime != infinity
{
    if lifetime <= 0 
    {
        with storage_id refill();

		snd_play_rndpitch(choose(sfx_ice_shatter_3, sfx_ice_shatter_4));
		
		repeat(4)
		{
			with vfx_create_particle(x, y - 8, sp_white, 1/16, 1/16)
			{
				move_in_dir = true;
				dir = irandom_range(0, 360);
				var _x = lengthdir_x(1, dir);
				var _y = lengthdir_y(1, dir);
				_x -= 0.5;
				dir = point_direction(0, 0, _x, _y);
				spd = random_range(0.5, 1.5);
				decell = -1/30;
				scale_spd_x = -(1/16)/60;
				scale_spd_y = -(1/16)/60;
				time = 60;
			}
		}
		
        instance_destroy();
    }
    else 
	{
		lifetime--;
		var _life = lifetime/(5 * 60);
		var _str = 2 * (1 -_life)
		myshake.shake(_str, _str+1);

		with storage_id time_left = other.lifetime;
		
	}
}

squash_x = lerp(squash_x, 1, 0.15);
squash_y = lerp(squash_y, 1, 0.15);


// - COLLIDER CHECK

	if collision_rectangle(x - 8, y - 16, x + 8, y, ob_plr, false, false)
	{
		collider_on = false;
	}

	if is_falling collider_on = false;

	mask_index = collider_on ? collider_spr : sp_nocollider;

//-

// - SPIKE CHECK
	on_spike = place_meeting(x, y, ob_spike);

	if on_spike 
	{
		if dmg_rate <= 0 
		{
			pop();
		}
		else dmg_rate--;
	}
	else dmg_rate = 30;

// -
