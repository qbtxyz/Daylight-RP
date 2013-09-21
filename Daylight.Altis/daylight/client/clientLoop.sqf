/*
	Description:	Loop ran on client that takes care of misc things
	Author:			qbt
*/

_arrVehiclesWithImpoundActionAdded = [];

_iLastPaycheckTime = time;

while {true} do {
	// Determine if players are near
	_arrNearMen = nearestObjects [player, ["CAManBase"], 4];
	_arrNearPlayers = [];
	{
		if (((isPlayer _x) && (_x != player) && (alive _x))) then {
			_arrNearPlayers set [count _arrNearPlayers, _x];
		};
	} forEach _arrNearMen;

	if ((count _arrNearPlayers) == 0) then {
		daylight_bPlayerNears = false;
	} else {
		daylight_bPlayerNears = true;
	};

	// BLUFOR stuff
	if ((side player) == blufor) then {
		if ((cursorTarget isKindOf "Car") && (isNull(driver(cursorTarget)))) then {
			if ((_arrVehiclesWithImpoundActionAdded find cursorTarget) == -1) then {
				cursorTarget addAction daylight_cfg_arrImpoundAction;

				_arrVehiclesWithImpoundActionAdded set [count _arrVehiclesWithImpoundActionAdded, cursorTarget];
			};
		};
	};

	// Paycheck
	if ((time - _iLastPaycheckTime) >= daylight_cfg_iPaycheckInterval) then {
		_iPaycheckAmount = daylight_cfg_iPaycheckCivilian;

		if ((side player) == blufor) then {
			_iPaycheckAmount = daylight_cfg_iPaycheckBlufor;
		};

		// Get current bank money
		_iMoneyBank = [player, format["iMoneyBank%1", player call daylight_fnc_returnSideStringForSavedVariables], 0] call daylight_fnc_loadVar;

		// Add paycheck to it
		_iMoneyBank = _iMoneyBank + _iPaycheckAmount;

		// Update bank money amount
		[player, format["iMoneyBank%1", player call daylight_fnc_returnSideStringForSavedVariables], _iMoneyBank] call daylight_fnc_saveVar;

		// Show notification
		[localize "STR_PAYCHECK_MESSAGE_TITLE", format[localize "STR_PAYCHECK_MESSAGE_RECEIVED", _iPaycheckAmount, localize "STR_CURRENCY", _iMoneyBank, (daylight_cfg_iPaycheckInterval call daylight_fnc_secondsToMinutesAndSeconds) select 0], true] call daylight_fnc_showHint;

		_iLastPaycheckTime = time;
	};

	sleep 0.5;
};