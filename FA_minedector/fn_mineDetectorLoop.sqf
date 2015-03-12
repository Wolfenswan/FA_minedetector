private ["_radius","_border","_unit","_nearmines","_nearestmine","_dirtomine"];

// Radius in which to detect mines
_radius = 25;

// How far off the center the mine can be to be detected (gradient)
_border = 25;

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

	if (count _nearmines == 1) then {
		_nearestmine = _nearmines select 0;
		_dirtomine = ([_unit, [getposATL _nearestmine select 0,getposATL _nearestmine select 1,0]] call BIS_fnc_relativedirTo);

		if (mineActive _nearestmine && {_dirToMine <= _border || _dirToMine >= (360-_border)}) then {
			uisleep (((_unit distance _nearestmine)/25) max 0.1); //sleep in shorter intervals but at least 0.1 seconds

			// "Tock"
			// playSound3D ["A3\missions_f\data\sounds\click.wss", _unit, false, eyePos _unit, 4, 5, 3];

			// "Ping"
			playSound3D ["a3\missions_f_beta\data\sounds\firing_drills\drill_start.wss", _unit, false, eyePos _unit, 2, 2, 4.5];
		};
	};

	uisleep 0.1;

	// If unit misplaced the mine detector, exit the loop
	if !("MineDetector" in (items _unit)) exitWith {_unit setVariable ["ws_var_mineDetector",false];};
};