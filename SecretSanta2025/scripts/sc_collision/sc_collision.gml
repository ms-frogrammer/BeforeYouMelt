function collide_and_move() {
	
	if place_meeting(x + hsp, y,  [ob_col, ob_block_par]) {
	
		repeat(abs(hsp) + 1){
			if(place_meeting(x + sign(hsp), y,  [ob_col, ob_block_par]))
				break;
			x += sign(hsp);
		}
			
		hsp = 0;
	}
	x += hsp;
		
	if place_meeting(x, y + vsp,  [ob_col, ob_block_par]) {
	
		repeat(abs(vsp) + 1){
			if(place_meeting(x, y + sign(vsp), [ob_col, ob_block_par]))
				break;
			y += sign(vsp);
		}
			
		vsp = 0;
	}
	y += vsp;
}