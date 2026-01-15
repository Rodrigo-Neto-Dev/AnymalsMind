enum P1State {
	IDLE,
	GROUNDED,
	FLYING,
	SWIMMING,
	CLIMBING,
	DASHING
}

enum P2State {}

p1_states = [];
p2_states = [];

function getP1States() {
    return global.p1_states;
}

function getP2States() {
	return global.p2_states;
}

function getStates(player_str) {
	var player = string_upper(player_str);
	
	switch (player) {
		case "P1": return global.p1_states;
		case "P2": return global.p2_states;
		default: return [];
	}
}

function addP1State(state) {
	if (not containsP1State(state)) {
	    array_push(global.p1_states, state);
	}
}

function addP2State(state) {
	if (not containsP2State(state)) {
	    array_push(global.p2_states, state);
	}
}

function delP1State(state) {
	delState("p1", state);
}

function delP2State(state) {
	delState("p2", state);
}

function delState(player_str, state) {
	var states = getStates(player_str);
	
	for (var i = 0; i < array_length(states); i++) {
		if (state == states[i]) {
			array_delete(states, i, 1);
		}
	}
}

function containsP1State(state) {
	return array_contains(getStates("p1"), state);
}

function containsP2State(state) {
	return array_contains(getStates("p2"), state);
}

function toStringP1States() {
	return toStringStates(getP1States());
}

function toStringP2States() {
	return toStringStates(getP2States());
}

function toStringStates(states) {
	var state_string = "[";
	
	if (array_length(states) != 0) {
		state_string += toStringP1State(states[0]) + toStringP2State(states[0]);
	}
	
	for (var i = 1; i < array_length(states); i++) {
		state_string += ", ";
		state_string += toStringP1State(states[i]) + toStringP2State(states[i]);
	}
	
	state_string += "]";
	
	return state_string;
}

function toStringP1State(state) {
	switch (state) {
		case P1State.IDLE: return "IDLE";
		case P1State.GROUNDED: return "GROUNDED";
		case P1State.FLYING: return "FLYING";
		case P1State.SWIMMING: return "SWIMMING";
		case P1State.CLIMBING: return "CLIMBING";
		case P1State.DASHING: return "DASHING";
		default: return "";
	}
}

function toStringP2State(state) {
	switch (state) {
		default: return "";
	}
}