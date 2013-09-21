/*
	Description:	Handle Killed-EH
	Author:			qbt
*/

/*
	Description:	Handle Killed-EH for players, clientside.
	Args:			nothing
	Return:			nothing
*/
daylight_fnc_handleKilledPlayer = {
	daylight_bRespawning = true;

	disableSerialization;

	// Handle simulation and adding "Study body"-actions
	player spawn daylight_fnc_handleKilledPlayerSimulationAndActions;

	// If BLUFOR, remove weapons
	if ((side player) == blufor) then {
		removeAllWeapons player;
	};

	// Remove all other effects from screen
	titleText ["", "PLAIN", 0.001];
	cutText ["", "PLAIN", 0.001];

	// Draw death message
	1500 cutRsc ["GeneralMsg", "PLAIN", 0.001];

	// Fade out sound fx
	[5, 0] call daylight_fnc_setMasterVolume;
	enableEnvironment false;

	// Dump inventory and reset inventory variable
	{

	} forEach daylight_arrInventory;

	daylight_arrInventory = [];

	// Calculate respawn time from amount of kills
	_iRespawnTime = daylight_cfg_iRespawnTimeMin;
	_arrKills = [player, "arrKills", 0] call daylight_fnc_loadVar;

	_iRespawnTime = _iRespawnTime + ((_arrKills select 0) * (daylight_cfg_arrRespawnTimeAddedPerKillPerSide select 0)) + ((_arrKills select 1) * (daylight_cfg_arrRespawnTimeAddedPerKillPerSide select 1));

	// Reset killcount after calculation is done
	[player, "arrKills", [0, 0]] call daylight_fnc_saveVar;

	// Determine how player got killed
	if (isNull (_this select 1)) then {
		// Player got killed by collision damage, fire, etc.
	} else {
		// Killed by other player:
		// Add to other players killcount depending on player side
		_arrKillerKills = [(_this select 1), "arrKills", [0, 0]] call daylight_fnc_loadVar;
		if ((side player) == blufor) then {
			[(_this select 1), "arrKills", [_arrKillerKills select 0, (_arrKillerKills select 1) + 1]] call daylight_fnc_saveVar;
		} else {
			[(_this select 1), "arrKills", [(_arrKillerKills select 0) + 1, _arrKillerKills select 1]] call daylight_fnc_saveVar;
		};
	};

	// Get variables set in RscTitles.hpp so we can use them
	_dDisplay = ((uiNamespace getVariable "daylight_arrRscGeneralMsg") select 0);
	_iIDC = ((uiNamespace getVariable "daylight_arrRscGeneralMsg") select 1);
	_cControl = _dDisplay displayCtrl _iIDC;

	_strText = "";
	for "_i" from 0 to (_iRespawnTime - 1) do {
		_iTimeLeft = _iRespawnTime - _i;

		_strText = format[format["%1%2", localize "STR_RESPAWN", localize "STR_RESPAWN_IN"], _iTimeLeft];

		_cControl ctrlSetStructuredText parseText(_strText);

		sleep 1;
	};

	daylight_bReadyToRespawn = true;

	// Set "ready"-text
	_cControl ctrlSetStructuredText parseText(format["%1%2", localize "STR_RESPAWN", localize "STR_RESPAWN_READY"]);
};

/*
	Description:	Respawn player (after player pressed spacebar)
	Args:			nothing
	Return:			nothing
*/
daylight_fnc_respawn = {
	daylight_bReadyToRespawn = false;

	// Wait until player actually respawns
	waitUntil {alive player};

	// Reset player state
	player setVariable ["daylight_arrState", [0, 0, 0], true]; // [i hands up, i restrained, i jailed]

	// Add default EH's
	player call daylight_fnc_addDefaultEventHandlers;

	// Set custom recoilCoefficient to player
	player setUnitRecoilCoefficient daylight_cfg_iRecoilCoefficient;

	// Set dir to respawn dir and pos to actual respawn pos
	player setDir daylight_cfg_iRespawnDir;
	player setPosATL daylight_cfg_arrRespawnPos;

	// Fade back sound
	[0, 1] call daylight_fnc_setMasterVolume;
	enableEnvironment true;

	// Remove death message
	1500 cutRsc ["RscStatic", "PLAIN", 0.001];

	daylight_bRespawning = false;
};

/*
	Description:	Handle dead player
	Args:			obj player
	Return:			nothing
*/
daylight_fnc_handleKilledPlayerSimulationAndActions = {
	_bLoop = true;
	_iLoops = 0;
	while {_bLoop} do {
		if ((((_this selectionPosition "Neck") select 2) <= 0.3) && ((speed _this) <= 0.25)) then {
			_iLoops = _iLoops + 1;
		};

		if (_iLoops == 10) then {
			_bLoop = false;
		};

		sleep 1;
	};

	[_this, false] call daylight_fnc_networkEnableSimulation;
};