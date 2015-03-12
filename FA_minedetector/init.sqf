if !(isServer) exitWith {};

// Wait for the mission to begin
sleep 0.1;

// begin main loop
while {count (playableUnits + switchableUnits) > 0} do {

	{
		if (isPlayer _x && {("MineDetector" in (items _x)) && !(_x getVariable ["ws_var_mineDetector",false])}) then {
			_x setVariable ["ws_var_mineDetector",true];
			_x spawn FA_fnc_mineDetector;
		};
	} forEach playableUnits + switchableUnits;

	// Check only every 10 seconds to save perfomance
	uisleep 10;
};