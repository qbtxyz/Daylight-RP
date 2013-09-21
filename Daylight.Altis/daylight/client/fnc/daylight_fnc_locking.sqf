/*
	Description:	Vehicle locking/unlocking functions
	Author:			qbt
*/

/*
	Description:	Toggle vehicle locked status (no keys check)
	Args:			obj vehicle
	Return:			nothing
*/
daylight_fnc_toggleVehicleLock = {
	[_this, (_this select 1) call daylight_fnc_toggledVehicleLockedNumber] call daylight_fnc_networkLockVehicle;
};

/*
	Description:	Check if player has keys for vehicle
	Args:			arr [obj player, obj vehicle]
	Return:			bool
*/
daylight_fnc_hasKeysFor = {
	_bHasKeys = false;

	_arrKeys = [(_this select 0), format["arrKeys%1", player call daylight_fnc_returnSideStringForSavedVariables], []] call daylight_fnc_loadVar;

	if ((_this select 1) in _arrKeys) then {
		_bHasKeys = true;
	};

	_bHasKeys
};

/*
	Description:	Return toggled vehicle locked status number
	Args:			obj vehicle
	Return:			int lock-status
*/
daylight_fnc_toggledVehicleLockedNumber = {
	_iReturn = 0;

	if ((locked _this) != 2) then {
		_iReturn = 2;
	};

	_iReturn
};