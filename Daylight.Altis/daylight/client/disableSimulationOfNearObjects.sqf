/*	
	Description: 	Disables damage and simulation of near buildings and objects.
	Author:			qbt
*/

while {true} do {
	_arrNearestObjects = nearestObjects [vehicle(player), ["Static"], 250];
	{
		_x allowDamage false;

		if (!(_x isKindOf "ReammoBox") && (daylight_cfg_arrSimluationEnabled find _x == -1)) then {
			_x enableSimulation false;
		};

		sleep 0.05;
	} forEach _arrNearestObjects;

	sleep 5;
};

if (true) exitWith {};