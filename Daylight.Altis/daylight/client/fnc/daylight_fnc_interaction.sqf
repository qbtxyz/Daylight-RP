/*
	Description:	Interaction functions
	Author:			qbt
*/

/*
	Description:	Introduce self
	Args:			obj cursorTarget
	Return:			nothing
*/
daylight_fnc_interactionIntroduceSelf = {
	// Get current var
	_arrIntroducedPlayerIDs = [player, "arrIntroducedPlayerIDsCivilian", [""]] call daylight_fnc_loadVar;

	// Check if cursorTarget already in authed players
	if (!([player, _this] call daylight_fnc_hasIntroducedTo)) then {
		_arrIntroducedPlayerIDs set [count _arrIntroducedPlayerIDs, getPlayerUID(_this)];

		// Update it
		[player, "arrIntroducedPlayerIDsCivilian", _arrIntroducedPlayerIDs] call daylight_fnc_saveVar;

		// Tell player introduction was successful
		["<t size=""2"">You've introduced yourself!</t>"] call daylight_fnc_showActionMsg; // TO-DO: Localize
	};
};

/*
	Description:	Open InteractionMenu UI
	Args:			obj cursorTarget
	Return:			nothing
*/
daylight_fnc_interactionOpenUI = {
	if (!dialog && !daylight_bRestrained && !daylight_bSurrendered && !daylight_bJailed && ((vehicle player) == player)) then {
		createDialog "InteractionMenu";

		daylight_vehInteractionCurrentPlayer = cursorTarget;

		while {(sliderRange 1900 select 1) != daylight_cfg_iMaxJailTimeByPolice} do {
			sliderSetPosition [1900, 1];
			sliderSetRange [1900, 1, daylight_cfg_iMaxJailTimeByPolice];
			sliderSetSpeed [1900, 0, 0];
		};

			// Set jail button text
		(uiNamespace getVariable "daylight_dsplActive" displayCtrl 1704) ctrlSetText format[localize "STR_INTERACTIONMENU_BUTTON_JAILFOR", round(sliderPosition 1900)];

		// Disable buttons that we cant use depending on cursorTarget state
		_arrState = daylight_vehInteractionCurrentPlayer getVariable "daylight_arrState";

		if (((_arrState select 0) == 0) && ((_arrState select 1) == 0) && ((_arrState select 2) == 0)) then {
			ctrlEnable [1701, false];
			ctrlEnable [1702, false];
			ctrlEnable [1703, false];
			ctrlEnable [1704, false];

			ctrlEnable [1900, false];
		};

		// Monitor dialog and close it if target gets too far away
		[] spawn daylight_fnc_interactionUIMonitor;
	};
};

/*
	Description:	Monitor InteractionMenu UI
	Args:			nothing
	Return:			nothing
*/
daylight_fnc_interactionUIMonitor = {
	while {((player distance daylight_vehInteractionCurrentPlayer) < daylight_cfg_iMaxDistanceFromInteractedUnit) && daylight_bDialogInteractionMenuOpen} do {
		// Disable buttons that we cant use depending on cursorTarget state
		_arrState = daylight_vehInteractionCurrentPlayer getVariable "daylight_arrState";
		_bEnable = false;
		if (((_arrState select 0) == 1) || ((_arrState select 1) == 1) && ((_arrState select 2) == 0)) then {
			_bEnable = true;
		};

		if (daylight_bDialogInteractionMenuOpen) then {
			ctrlEnable [1701, _bEnable];
			ctrlEnable [1702, _bEnable];
			ctrlEnable [1703, _bEnable];
			ctrlEnable [1704, _bEnable];

			ctrlEnable [1900, _bEnable];
		};

		sliderSetSpeed [1900, 1, 1];

		sleep 0.25;
	};

	// Show notification
	if (daylight_bDialogInteractionMenuOpen) then {
		[localize "STR_INTERACTION_MENU_TITLE", localize "STR_INTERACTION_MENU_TARGETTOOFAR", true] call daylight_fnc_showHint;
	};

	// Double close dialog (if player has 2 windows open)
	while {daylight_bDialogInteractionMenuOpen} do {
		closeDialog 0;

		sleep 0.01;
	};

	if (true) exitWith {};
};

/*
	Description:	Body search RETURN
	Args:			arr [obj searched, arr inventory]
	Return:			nothing
*/
daylight_fnc_interactionBodySearchReturn = {
	// Populate inventory item list from inventory array
	_strInventory = "";
	for "_i" from 0 to ((count (_this select 1)) - 1) do {
		// Get item ID and amount from the current array
		_iItemID = ((_this select 1) select _i) select 0;
		_iItemAmount = ((_this select 1) select _i) select 1;

		// Get item text
		_strItemText = ((_iItemID call daylight_fnc_invIDToStr) select 0);

		// Different text if the amount is more than 1
		if (_iItemAmount != 1) then {
			_strItemText = format["%1 (%2)", _strItemText, _iItemAmount];
		};

		// If item is in illegal ID's range, set text color to red
		if ((_iItemID >= (daylight_cfg_arrInvIllegalIDRange select 0)) && (_iItemID <= (daylight_cfg_arrInvIllegalIDRange select 1))) then {
			_strItemText = format["<t color=""#ff0000"">%1</t>", _strItemText];
		};

		_strInventory = format["%1<br/>%2", _strInventory, _strItemText];
	};

	_strName = ([(_this select 0), format["arrCharacterData%1", (_this select 0) call daylight_fnc_returnSideStringForSavedVariables], ["", ""]] call daylight_fnc_loadVar) select 0;

	closeDialog 0;
	[format[localize "STR_BODY_SEARCH_INVENTORY_TITLE", _strName, name(_this select 0)], format[localize "STR_BODY_SEARCH_INVENTORY", _strName, name(_this select 0), _strInventory]] call daylight_fnc_showNotificationWindow; // TO-DO: Localize
};

/*
	Description:	Restrain self
	Args:			obj restrainer
	Return:			nothing
*/
daylight_fnc_interactionRestrainToggle = {
	if (!daylight_bRestrained) then {
		// Set player state as restrained
		[player, [0, 1, -1]] call daylight_fnc_handlePlayerState;
		daylight_bRestrained = true;
		daylight_bSurrendered = false;

		// Reset anim
		player playMoveNow "";
		player switchMove "";
		[player, ""] call daylight_fnc_networkSwitchMove;

		// Show notification
		[localize "STR_INTERACTION_MENU_RESTRAINED_TITLE", format[localize "STR_INTERACTION_MENU_RESTRAINED", ([_this, format["arrCharacterData%1", _this call daylight_fnc_returnSideStringForSavedVariables], ["", ""]] call daylight_fnc_loadVar) select 0, name(_this)], true] call daylight_fnc_showHint;

		while {((player distance _this) <= daylight_cfg_iMaxRestrainerDistanceFromRestrainee) && (((player getVariable "daylight_arrState") select 1) == 1)} do {
			player playMoveNow "AmovPercMstpSnonWnonDnon_Ease";

			sleep 0.01;
		};

		if ((player distance _this) > daylight_cfg_iMaxRestrainerDistanceFromRestrainee) then {
			// Set player state as unrestrained
			[player, [0, 0, -1]] call daylight_fnc_handlePlayerState;
			daylight_bRestrained = false;

			// Show notification
			[localize "STR_INTERACTION_MENU_UNRESTRAINED_TITLE", localize "STR_INTERACTION_MENU_UNRESTRAINED_BROKEFREE", true] call daylight_fnc_showHint;
		};
	} else {
		// Set player state as unrestrained
		[player, [0, 0, -1]] call daylight_fnc_handlePlayerState;
		daylight_bRestrained = false;

		// Show notification
		[localize "STR_INTERACTION_MENU_UNRESTRAINED_TITLE", format[localize "STR_INTERACTION_MENU_UNRESTRAINED", ([_this, format["arrCharacterData%1", _this call daylight_fnc_returnSideStringForSavedVariables], ["", ""]] call daylight_fnc_loadVar) select 0, name(_this)], true] call daylight_fnc_showHint;
	};

	if (true) exitWith {};
};

/*
	Description:	Surrender toggle
	Args:			nothing
	Return:			nothing
*/
daylight_fnc_interactionSurrenderToggle = {
	if (!daylight_bRestrained && !daylight_bJailed && ((vehicle player) == player)) then {
		if (!daylight_bSurrendered) then {
			// Set player state as surrendered
			[player, [1, 0, -1]] call daylight_fnc_handlePlayerState;
			daylight_bSurrendered = true;

			// Play surrender animation (fix for normal surrender anim by micovery from feedback.arma3.com)
			player playMoveNow "CutSceneAnimationBaseZoZo";
			[player, "TestSurrender"] call daylight_fnc_networkSwitchMove;
		} else {
			// Set player state as not surrendered
			[player, [0, 0, -1]] call daylight_fnc_handlePlayerState;
			daylight_bSurrendered = false;

			// Play un-surrender animation (fix for normal surrender anim by micovery from feedback.arma3.com)
			player switchMove "AmovPercMstpSnonWnonDnon";
			[player, "AmovPercMstpSnonWnonDnon"] call daylight_fnc_networkSwitchMove;
		};
	};
};

/*
	Description:	Open give ticket UI
	Args:			arr [veh ticketer, i amount, str reason]
	Return:			nothing
*/
daylight_fnc_interactionOpenGiveTicketUI = {
	createDialog "GiveTicket";
};

/*
	Description:	Open pay ticket UI
	Args:			arr [veh ticketer, i amount, str reason]
	Return:			nothing
*/
daylight_fnc_interactionOpenPayTicketUI = {
	createDialog "PayTicket";

	daylight_vehCurrentTicketer = (_this select 0);

	// Set structured text
	((uiNamespace getVariable "daylight_dsplActive") displayCtrl 1100) ctrlSetStructuredText (parseText(format[localize "STR_TICKET_QUESTION_MESSAGE", ([(_this select 0), format["arrCharacterData%1", (_this select 0) call daylight_fnc_returnSideStringForSavedVariables], ["", ""]] call daylight_fnc_loadVar) select 0, name((_this select 0)), (_this select 1), localize "STR_CURRENCY", (_this select 2)]));
};

/*
	Description:	Handle ticket response
	Args:			arr [veh ticketed, b response]
	Return:			nothing
*/
daylight_fnc_interactionHandleTicketResponse = {
	hint str _this;
};

/*
	Description:	Seize illegal items
	Args:			veh player who wanted to remove illegal items
	Return:			nothing
*/
daylight_fnc_interactionSeizeIllegalItems = {
	// Remove illegal items
	_iIllegalItemsCount = 0;
	for "_i" from 0 to ((count daylight_arrInventory) - 1) do {
		// Get item ID and amount from the current array
		_iItemID = (daylight_arrInventory select _i) select 0;

		// If item is in illegal ID's range, set text color to red
		if ((_iItemID >= (daylight_cfg_arrInvIllegalIDRange select 0)) && (_iItemID <= (daylight_cfg_arrInvIllegalIDRange select 1))) then {
			daylight_arrInventory set [_i, -1];

			_iIllegalItemsCount = _iIllegalItemsCount + 1;
		};
	};

	daylight_arrInventory = daylight_arrInventory - [-1];

	// Show notification if player was carrying illegal items
	if (_iIllegalItemsCount != 0) then {
		[localize "STR_INTERACTION_MENU_TITLE", format[localize "STR_INTERACTION_MENU_ILLEGALITEMSREMOVEDBY", ([_this, format["arrCharacterData%1", _this call daylight_fnc_returnSideStringForSavedVariables], ["", ""]] call daylight_fnc_loadVar) select 0, name(_this)], true] call daylight_fnc_showHint;
	};
};