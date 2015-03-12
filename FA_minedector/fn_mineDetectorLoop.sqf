private ["_radius","_unit","_nearmines","_nearestmine"];

// Radius in which to detect mines
_radius = 60;

_unit = _this;
while {alive _unit} do {

	// Get all mines in the given radius
	// Awkward solution as nearObjects is bugged wrt to mines when filtering for a type and will only return APERS mines for type "mineGeneric"
	_nearmines = [];
	{
		if (mineActive _x && {_x distance _unit <= _radius}) then {
			_nearmines pushback (_x);
		};
	} forEach allMines;

	// Resize the array until only one mine is left
	while {count _nearmines > 1} do {
		if (((_nearmines select 0) distance _unit > (_nearmines select 1) distance _unit)) then [{_nearmines deleteAt 0},{_nearmines deleteAt 1}];
	};

	_nearestmine = _nearmines select 0;

	// WIP on directionality
	//_dirtomine = [_unit, getposATL _nearmine] call BIS_fnc_dirTo;

	if (mineActive _nearestmine) then {
		uisleep (((_unit distance _nearestmine)/25) max 0.1); //sleep in shorter intervals but at least 0.1 seconds

		// "Tock"
		//playSound3D ["A3\missions_f\data\sounds\click.wss", _unit, false, eyePos _unit, 4, 5, 3];

		// "Ping"
		playSound3D ["a3\missions_f_beta\data\sounds\firing_drills\drill_start.wss", _unit, false, eyePos _unit, 3, 2, 3];
	};

	sleep 0.1;

	// If unit misplaced the mine detector, exit the loop
	if !("MineDetector" in (items _unit)) exitWith {_unit setVariable ["ws_var_mineDetector",false];};
};