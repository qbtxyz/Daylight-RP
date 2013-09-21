/*
	Description:	Misc CLIENT functions
	Author:			qbt
*/

/*
	Description:	Disable respawn button
	Args:			nothing
	Return:			nothing
*/
daylight_fnc_disableRespawnButton = {
	disableSerialization;

	// Wait until IngamePause menu display comes active
	waitUntil {!(isNull (findDisplay 49))};

	// Disable respawn button
	((findDisplay 49) displayCtrl 1010) ctrlEnable false;

	// Exit thread
	if (true) exitWith {};
};

/*
	Description:	Add needed EH's to player
	Args:			nothing
	Return:			nothing
*/
daylight_fnc_addDefaultEventHandlers = {
	_this addEventHandler ["Killed", {_this spawn daylight_fnc_handleKilledPlayer}];
};

/*
	Description:	Remove attached EH's from player
	Args:			nothing
	Return:			nothing
*/
daylight_fnc_removeDefaultEventHandlers = {
	_this removeAllEventHandlers "Killed";
};

/*
	Description:	Control game master volume
	Args:			arr [int time, int vol]
	Return:			nothing
*/
daylight_fnc_setMasterVolume = {
	(_this select 0) fadeSound (_this select 1);
	(_this select 0) fadeSpeech (_this select 1);
	(_this select 0) fadeMusic (_this select 1);
	(_this select 0) fadeRadio (_this select 1);
};

/*
	Description:	Show action text
	Args:			arr [str text, (int time)]
	Return:			nothing
*/
daylight_fnc_showActionMsg = {
	_iTime = (_this select 1);

	// disableSerialization so we can work with UI datatypes
	disableSerialization;

	// Show message
	if (!(isNil "_iTime")) then {
		202 cutRsc ["actionMsg", "PLAIN", _iTime];
	} else {
		202 cutRsc ["actionMsg", "PLAIN", 2];
	};

	// Get variables set in RscTitles.hpp
	_dDisplay = ((uiNamespace getVariable "daylight_arrRscActionMsg") select 0);
	_iIDC = ((uiNamespace getVariable "daylight_arrRscActionMsg") select 1);
	_cControl = _dDisplay displayCtrl _iIDC;

	// Set text
	_cControl ctrlSetStructuredText (parseText format["<t align=""center"" size=""1.8"" shadow=""1"">%1</t>", (_this select 0)]);
};

/*
	Description:	Broadcasts whistle sound
	Args:			obj whistler
	Return:			nothing
*/

// Keep track of time last whistled
daylight_iLastWhistleTime = 0;

daylight_fnc_whistle = {
	if (((time - daylight_iLastWhistleTime) > 5) && !(underwater player)) then {
		daylight_iLastWhistleTime = time;

		_arrSounds = [
			"66419_Robinhood76_00724_folk_whistle_short_4_1",
			"66419_Robinhood76_00724_folk_whistle_short_4_2"
		];

		// Select random sound from _arrSounds
		_strSound = _arrSounds call BIS_fnc_selectRandom;

		// Play the sound locally and broadcast it as positional audio as well
		playSound _strSound;
		[player, _strSound] call daylight_fnc_networkSay3D;
	};
};

/*
	Description:	Return players in certain radius (including self)
	Args:			arr [obj from, int radius]
	Return:			arr [obj players in radius]
*/
daylight_fnc_playersInRadius = {
	_arrPlayers = [];

	{
		if (((_this select 0) distance _x) <= (_this select 1)) then {
			_arrPlayers set [count _arrPlayers, _x];
		};
	} forEach playableUnits;

	_arrPlayers
};

/*
	Description:	Return side string for saved variables, "civilian" for civ and "blufor" for blufor
	Args:			obj player
	Return:			bool
*/
daylight_fnc_returnSideStringForSavedVariables = {
	_strReturn = "Civilian";

	if ((side _this) == blufor) then {
		_strReturn = "Blufor"
	};

	_strReturn
};

/*
	Description:	Removes items from cargo
	Args:			[obj cargo, str item to remove]
	Return:			nothing
*/
daylight_fnc_removeItemsFromCargo = {
	_arrCurrentCargo = (itemCargo (_this select 0)) call daylight_fnc_lowercaseStringInArray;

	if ((_arrCurrentCargo find (_this select 1)) != -1) then {
		_arrNewCargo = _arrCurrentCargo - [(_this select 1)];

		_arrItemsProcessed = [];

		// Clear cargo
		clearItemCargoGlobal (_this select 0);

		{
			if ((_arrItemsProcessed find _x) == -1) then {
				(_this select 0) addItemCargoGlobal [_x, [_x, _arrNewCargo] call daylight_fnc_countOccurencesInArray];
				_arrItemsProcessed set [count _arrItemsProcessed, _x];
			};
		} forEach _arrNewCargo;
	};
};

/*
	Description:	Find occurences in array
	Args:			[any needle, arr haystack]
	Return:			int amount of occurences
*/
daylight_fnc_countOccurencesInArray = {
	_iOccurences = 0;

	{
		if (_x == (_this select 0)) then {
			_iOccurences = _iOccurences + 1;
		};
	} forEach (_this select 1);

	_iOccurences
};

/*
	Description:	Lowercase strings in arrays
	Args:			arr array
	Return:			arr lowercased strings in array
*/
daylight_fnc_lowercaseStringInArray = {
	_arrOuput = [];

	{
		if (typeName _x == "STRING") then {
			_arrOuput set [count _arrOuput, toLower(_x)];
		} else {
			_arrOuput set [count _arrOuput, _x];
		};
	} forEach _this;

	_arrOuput
};

/*
	Description:	Withdraw from bank
	Args:			arr [str title, str message, b playSound]
	Return:			nothing
*/
daylight_fnc_showHint = {
	_strMessage = parseText(format["<t size=""1.5"" color=""#ff0000"" underline=""1"">%1</t><br/><br/><t size=""0.95"" color=""#ffffff"">%2</t>", (_this select 0), (_this select 1)]);

	if ((_this select 2)) then {
		hint _strMessage;
	} else {
		hintSilent _strMessage;
	};
};

/*
	Description:	Create notification window
	Args:			arr [str title, str message]
	Return:			nothing
*/
daylight_fnc_showNotificationWindow = {
	createDialog "NotificationWindow";

	// Set title
	ctrlSetText [1000, (_this select 0)];

	// Set structured text
	((uiNamespace getVariable "daylight_dsplActive") displayCtrl 1100) ctrlSetStructuredText (parseText(_this select 1));
};

/*
	Description:	Create & set default color correction
	Args:			nothing
	Return:			nothing
*/
daylight_fnc_setDefaultColorCorrection = {
	daylight_ppColorCorrection = ppEffectCreate ["ColorCorrections", 1550];
	daylight_ppColorCorrection ppEffectEnable true;

	daylight_ppColorCorrection ppEffectAdjust daylight_cfg_arrDefaultColorCorrection;
	daylight_ppColorCorrection ppEffectCommit 0;
};

/*
	Description:	Seconds to minutes
	Args:			int seconds
	Return:			arr [i minutes, i seconds]
*/
daylight_fnc_secondsToMinutesAndSeconds = {
	_arrOuput = [0, 0];

	_iMinutes = floor((_this / 60) % 60);
	_iSeconds = floor(_this % 60);

	if (_iMinutes < 0) then {
		_iMinutes = 0;
	};

	if (_iSeconds < 0) then {
		_iSeconds = 0;
	};

	_arrOuput = [_iMinutes, _iSeconds];

	_arrOuput
};