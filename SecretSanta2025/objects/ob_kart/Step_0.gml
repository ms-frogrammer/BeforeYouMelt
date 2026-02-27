var _on_ground = place_meeting(x, y + 1, [ob_col, ob_semisolid]);


if _on_ground
{
	var _dec = 0.025;
	hsp += clamp(-hsp, -_dec, _dec);
	
	if place_meeting(x + hsp, y, ob_plr) 
	{
		//var _acc = 0.25;
		//hsp += clamp(ob_plr.hsp - hsp, -_acc, _acc);
		
		if abs(ob_plr.hsp) > 1 && ob_plr.on_ground
		{
			hsp = ob_plr.hsp;
		}
	}
	
	
	if place_meeting(x, y, ob_push_button) hsp = clamp(hsp, -1, 1);

}
else vsp += grav;


if place_meeting(x + hsp, y, ob_col) && !place_meeting(x + hsp, y - 1, ob_col)
{
	y -= 1;
}
semisolid_tick();
collide_and_move();