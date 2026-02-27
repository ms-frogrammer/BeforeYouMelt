type = BLOCK_TYPE.SNOW;
lifetime = infinity;

switch(object_index)
{
    case ob_block_par:
        type = BLOCK_TYPE.SNOW
		
        break;
	case ob_ice:
        type = BLOCK_TYPE.ICE;
        if lifetime == infinity lifetime = 5 * 60;
		if lifetime != infinity image_index = sprite_get_number(sp_ice_decay)*(lifetime/(5*60))

        break;
    case ob_crate:
        type = BLOCK_TYPE.CRATE;

        break;
		
	case ob_key:
	    type = BLOCK_TYPE.KEY;
	    break;
		
    default:
        break;
}

is_stuck = false;
stuck_block = noone;
storage_id = noone;
is_falling = true;
dir = 270;
vsp = 0;
grav = 0.35;

collider_spr = sp_snow_decay;
collider_on = false;

squeeze = function(_x, _y)
{
    squash_x = _x;
    squash_y = _y;
}
squash_x = 1;
squash_y = 1;

squeeze(0.75, 0.75);

fall = function(_vsp)
{
    is_falling = true;
    dir = 270;
    vsp = _vsp;
}

stick_to = function(_dir, _block)
{
    squeeze(1.25, 1.25);
    is_stuck = true;
    stuck_block = _block;
    dir = _dir;

    is_falling = false;
    vsp = 0;

    mask_index = collider_spr;

    switch(dir)
    {
        case 0:
            x += stuck_block.bbox_left - bbox_right;
            break;
        case 90:
            y += stuck_block.bbox_bottom - bbox_top;
            break;
        case 180:
            x += stuck_block.bbox_right - bbox_left;
            break;
        case 270:
            if bbox_bottom != stuck_block.bbox_top
            {
                y += stuck_block.bbox_top - bbox_bottom;
            }
           
            break;
    }
	
    spawn_block = true;
}


dmg_rate = 30;
pop = function()
{
    if type == BLOCK_TYPE.CRATE exit;
    
    if type == BLOCK_TYPE.ICE
    {
        with storage_id refill();
    }

    vfx_create_anim(x, y, sp_effect_block_pop, true, choose(-1, 1), 1, 0);
    vfx_create_cloud(x, y - 8, sp_white, c_white, 5, 1.5, 2.5, 0.025, 0, 0.15, 0.33, -0.01, 120, false);

    instance_destroy();
}

myshake = new Shake();
shake_particle_rate = 0;

on_spike = false;

return_data = function() 
{
    var _vars = [
		"x", 
		"y", 
		"type",
        "lifetime",
        "is_stuck",
        "stuck_block",
        "storage_id",
        "is_falling",
        "dir",
        "vsp",
        "grav",
        "image_index",
	];

	return save_vars(id, _vars);
}