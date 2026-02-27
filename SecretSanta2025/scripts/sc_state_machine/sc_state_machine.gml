function states_setup(_default_state = "idle") {
	state = _default_state;
	state_next = _default_state;
	state_prev = "";
	state_last = "";
	state_start = false;
}

function states_update() {
	if state_next != state {
		state_last = state;
	}
	
	state_prev = state;
	state = state_next;
}

function states_tick()
{
	state_start = state != state_prev;
}