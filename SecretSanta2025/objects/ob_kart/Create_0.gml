hsp = 0;
vsp = 0;
weight = 2;
grav = 0.5;

function semisolid_tick() {
	
	for(var _y = y; _y <= y + max(ceil(vsp), 2); _y++)
	{
		var _semisolid = instance_place(x, _y, ob_semisolid);
		if _semisolid 
		{
			if round(bbox_bottom) < round(_semisolid.bbox_top) && 
			round(bbox_bottom) + vsp > round(_semisolid.bbox_top) {
				vsp = 0;
				y = y + (_semisolid.bbox_top - bbox_bottom);
				
			}
			else if round(bbox_bottom) == round(_semisolid.bbox_top) && vsp > 0 {
				vsp = 0;

			}
			break;
		}
	}
}

return_data = function()
{
	var _vars = [
		"x",
		"y",
		"hsp",
		"vsp",
	]
	
	return save_vars(id, _vars);
}