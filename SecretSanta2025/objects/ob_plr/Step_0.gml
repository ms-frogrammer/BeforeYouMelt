
 
// - LIVE
    jump_init_pow = -4;
    jump_force = -4;
    jump_time_max = 8;
    grav = 0.325;
    move_spd = 2.5;
    air_acc = 0.2;
    ground_acc = 0.65;
// -

// Find ground
on_ground = get_on_ground();

if on_ground {
    coyote_time = coyote_dur;

    if !landed
    {
        landed = true;
        land();
    }
}
else landed = false;


// - READ INPUT
    with r_input
    {
        hor = input_check_opposing("left", "right");
        ver = input_check_opposing("up", "down");
        jump_btn_press = input_check_pressed("jump");
        jump_btn_hold = input_check("jump");
        release_btn_press = input_check_pressed("release");
        release_btn_hold = input_check("release");
		grab_btn_press = input_check_pressed("grab");
        shift_hold = input_check("shift");
    }
	
    if !global.plr_input_enabled
    {
        with r_input
        {
            hor = 0;
            ver = 0;
            jump_btn_press = false;
            jump_btn_hold = false;
            release_btn_press = false;
            release_btn_hold = false;
            grab_btn_press = false;
            shift_hold = false;
        }
    }
	
	#region TUTORIAL
		if global.plr_tutorial
		{
			switch(global.tutorial_number)
			{
				case PLAYER_TUTORIAL.FINISH:
					global.plr_tutorial = false;
                    show_tutorial_message = false;
                    for(var i = 0; i < count_parts(); i++)
                    {
                        vfx_create_cloud(x, bbox_bottom - i * 16, sp_effect_circle, WHITE, 4, 1, 2, 0.05, -30, 0.5, 0.75, -1/30, 30, false, 1/120);
                    }

					break;
				
				case PLAYER_TUTORIAL.PLACE:
                    show_tutorial_message = true;
                    
                    with r_input
			        {
			            hor = 0;
			            ver = 0;
			            jump_btn_press = false;
			            jump_btn_hold = false
			            grab_btn_press = false;
                        shift_hold = false;
			        }

					break;
				case PLAYER_TUTORIAL.GRAB:
					with r_input
			        {
			            hor = 0;
			            ver = 0;
			            jump_btn_press = false;
			            jump_btn_hold = false
						release_btn_press = false;
						release_btn_hold = false;
                        shift_hold = false;
			        }
					break;
				case PLAYER_TUTORIAL.MOVE:
					with r_input
			        {
			            jump_btn_press = false;
			            jump_btn_hold = false
						release_btn_press = false;
						release_btn_hold = false;
                        shift_hold = false;
			        }

                    if r_input.hor > 0 && !global.tutorial_move.right
                    {
                        global.tutorial_move.right = true;
                        hsp = 1;
                    }
                    if r_input.hor < 0 && !global.tutorial_move.left 
                    {
                        global.tutorial_move.left = true;
                        hsp = -1;
                    }
                    if r_input.ver > 0 && !global.tutorial_move.down
                    {
                        global.tutorial_move.down = true;
                    }
                    if r_input.ver < 0 && !global.tutorial_move.up
                    {
                        global.tutorial_move.up = true;
                        vsp = -1;
                    }

                    update_tutorial_text();

                    r_input.hor = 0;
                    r_input.ver = 0;
                    
                    var _done = global.tutorial_move.up && global.tutorial_move.left && global.tutorial_move.down && global.tutorial_move.right;
                    if _done
                    {
                        switch_tutorial(PLAYER_TUTORIAL.JUMP);
                    }

					break;
                case PLAYER_TUTORIAL.JUMP:
                    with r_input
			        {
			            hor = 0;
                        ver = 0;
                        release_btn_press = false;
                        release_btn_hold = false;
                        grab_btn_press = false;
                        shift_hold = false;
			        }
					break;
			}
		}
	#endregion
// -

// Get acceleration 
acc = get_acc();
update_face_x();

// Do ability
predict_grab();
predict_ability();


// - ACTIONS

    if r_input.jump_btn_press jump_buffer = jump_buffer_max;
    var _death = !is_alive;
    var _move = r_input.hor != 0;
    var _jump = (jump_buffer > 0 && (on_ground || coyote_time>0));
    var _mini_jump = force_jump;
	var _release = r_input.release_btn_press && ability_rate <= 0;
    var _grab = r_input.grab_btn_press && instance_exists(grab_block) && on_ground;
    var _shift = r_input.shift_hold;
// -

// - PERFORM
    if _release
    {
        _jump = false;

        ability();
        ability_rate = ability_rate_max;

        coyote_time = 0;

        // - TUTORIAL
            if global.tutorial_number == PLAYER_TUTORIAL.PLACE && count_parts() <= 0
            {
                switch_tutorial(PLAYER_TUTORIAL.GRAB);
            }
            
    }

    if _grab 
    {
        _jump = false;

        grab();

        // - TUTORIAL
            if global.tutorial_number == PLAYER_TUTORIAL.GRAB && count_parts() >= 2
            {
                switch_tutorial(PLAYER_TUTORIAL.MOVE);
            }
    }

    if input_value("down") >= 0.85 && r_input.jump_btn_press && on_semisolid
    {
        _jump = false;

        ignore_semisolid_frames = 10;
        jump_buffer = 0;
        coyote_time = 0;
    
    }
// -

// - COUNTDOWN
    if ability_rate > 0 ability_rate--;
    if coyote_time > 0  coyote_time--;
    if jump_buffer > 0 jump_buffer--;
    if ignore_semisolid_frames > 0 ignore_semisolid_frames--;
    if dmg_rate > 0 dmg_rate--;
// -

vsp += grav;

// - STATE MACHINE
    states_tick();
    switch(state)
    {
        case "idle":
            // - START
                if state_start 
                {

                }

            // - STATE
                hsp += clamp(-hsp, -acc, acc);

            // - EXIT
                if _death {
                    state_next = "death";
                    break;
                }
                if _jump {
                    state_next = "jump";
                    break;
                }
                if _mini_jump
                {
                    state_next = "mini_jump";
                    break;
                }
                if !on_ground {
                    state_next = "fall";
                    break;
                }
                if _move {
                    state_next = "run";
                    break;
                }

            break;

        case "run":

            // - STATE
            move();

            // - EXIT
                if _death {
                    state_next = "death";
                    break;
                }
                if _jump {
                    state_next = "jump";
                    break;
                }
                if _mini_jump
                {
                    state_next = "mini_jump";
                    break;
                }
                if !on_ground {
                    state_next = "fall";
                    break;
                }
                if !_move {
                    state_next = "idle";
                    break;
                }

            break;

        case "mini_jump":
            jump_buffer = 0;
            coyote_time = 0;
            //vsp += grav;
            
            if state_start 
            {
                vsp = mini_jump_pow/get_weight();
                on_ground = false;
                force_jump = false;
            }

            move();

            // - EXIT
                if _death {
                    state_next = "death";
                    break;
                }
                if _mini_jump {
                    state = "fall";
                    state_next = "mini_jump";
                    break;
                }
                if vsp >= 0 {
                    state_next = "fall";
                    break;
                } 
                if on_ground {
                    state_next = _move ? "run" : "idle";
                    break;
                }

            break;

        case "jump":
            jump_buffer = 0;
            coyote_time = 0;
            //vsp += grav;
            
            if state_start 
            {
                vsp = jump_init_pow/get_weight();
                jump_time = 0;
                on_ground = false;
                force_jump = false;

                snd_play(sfx_jump_1, false);

                if global.tutorial_number == PLAYER_TUTORIAL.JUMP
                {
                    global.tutorial_number = PLAYER_TUTORIAL.FINISH;
                }
            }
            else 
            {

                if r_input.jump_btn_hold || r_input.release_btn_hold
                {
                   
                    if jump_time < jump_time_max
                    {
                        jump_time++;
                        vsp = min(vsp, jump_force/get_weight());
                    }
                }
                else jump_time = jump_time_max;
            }

            move();

            // - EXIT
                if _death {
                    state_next = "death";
                    break;
                }
                if _mini_jump {
                    state_next = "mini_jump";
                    break;
                }
                if vsp >= 0 {
                    state_next = "fall";
                    break;
                } 
                if on_ground {
                    state_next = _move ? "run" : "idle";
                    break;
                }
            break;

        case "fall":
            //vsp += grav;

            move();

            // - EXIT
                if _death {
                    state_next = "death";
                    break;
                }
                if _jump {
                    state_next = "jump";
                    break;
                }
                if _mini_jump
                {
                    state_next = "mini_jump";
                    break;
                }
                if on_ground {
                    state_next = _move ? "run" : "idle";
                    break;
                }
            break;

        case "death":
            vsp = 0;
            hsp = 0;

            if is_alive state_next = "idle";
            
            break;
    }
// -


if tutorial_delay > 0 tutorial_delay--;
else 
{
    if show_tutorial_message interact_cloud(x, y - 64, tutorial_text);
}



for(var i = 0; i < array_length(squash_x); i++)
{
    squash_x[i] = lerp(squash_x[i], 1, 0.15);
    squash_y[i] = lerp(squash_y[i], 1, 0.15);
}


semisolid_tick();
update_mask();

// Walk on ramps
if place_meeting(x + hsp, y, ob_col) && !place_meeting(x + hsp, y - 1, ob_col)
{
	y -= 1;
}

if count_parts() == 0
{
    if hsp != 0 head_tilt = lerp(head_tilt, sign(hsp) * -15, 0.2);
    else head_tilt = lerp(head_tilt, 0, 0.33);
}
else head_tilt = lerp(head_tilt, 0, 0.33);



if ob_room_handler.is_transitioning && !ob_room_handler.is_reloading
{
    x += lengthdir_x(3, global.plr_exit_dir * 90);
    y += lengthdir_y(3, global.plr_exit_dir * 90);
}
else collide_and_move();


// if keyboard_check_pressed(ord("1")) update_room_data();
// if keyboard_check_pressed(ord("2")) load_room_data();