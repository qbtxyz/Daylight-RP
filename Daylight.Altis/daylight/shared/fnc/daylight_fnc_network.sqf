/*	
	Description: 	SHARED network functions for Daylight
	Author:			qbt
*/

// Initialize PV's and PVEH's
if (isServer) then {
	daylight_arrPVLockVehicle = [];
	daylight_arrPVSay3D = [];
	daylight_arrPVBankTransfer = [];
	daylight_arrPVBodySearchDo = [];
	daylight_arrPVBodySearchReturn = [];
	daylight_arrPVRestrain = [];
	daylight_arrPVTicket = [];
	daylight_arrPVTicketReturn = [];
	daylight_arrPVSwitchMove = [];
	daylight_arrPVEnableSimulation = [];
	daylight_arrPVSeizeIllegalItems = [];
	daylight_arrPVJailPlayer = [];
	daylight_arrPVAllowDamage = [];
	daylight_arrPVShoutSend = [];
	daylight_arrPVMobilePhoneMessage = [];

	publicVariable "daylight_arrPVLockVehicle";
	publicVariable "daylight_arrPVSay3D";
	publicVariable "daylight_arrPVBankTransfer";
	publicVariable "daylight_arrPVBodySearchDo";
	publicVariable "daylight_arrPVBodySearchReturn";
	publicVariable "daylight_arrPVRestrain";
	publicVariable "daylight_arrPVTicket";
	publicVariable "daylight_arrPVTicketReturn";
	publicVariable "daylight_arrPVSwitchMove";
	publicVariable "daylight_arrPVEnableSimulation";
	publicVariable "daylight_arrPVSeizeIllegalItems";
	publicVariable "daylight_arrPVJailPlayer";
	publicVariable "daylight_arrPVAllowDamage";
	publicVariable "daylight_arrPVShoutSend";
	publicVariable "daylight_arrPVMobilePhoneMessage";
};

"daylight_arrPVLockVehicle" addPublicVariableEventHandler {
	((_this select 1) select 0) lock ((_this select 1) select 1);

	if (true) exitWith {};
};

"daylight_arrPVSay3D" addPublicVariableEventHandler {
	((_this select 1) select 0) say3D ((_this select 1) select 1);

	if (true) exitWith {};
};

"daylight_arrPVBodySearchDo" addPublicVariableEventHandler {
	if (((_this select 1) select 1) == player) then {
		((_this select 1) select 0) call daylight_fnc_networkBodySearchReturn;

		// Introduce self to officer, as the officer can already see name from body search
		((_this select 1) select 1) call daylight_fnc_interactionIntroduceSelf;
	};
};

"daylight_arrPVBodySearchReturn" addPublicVariableEventHandler {
	if (((_this select 1) select 0) == player) then {
		[(_this select 1) select 1, (_this select 1) select 2] call daylight_fnc_interactionBodySearchReturn;
	};
};

"daylight_arrPVRestrain" addPublicVariableEventHandler {
	if (((_this select 1) select 1) == player) then {
		((_this select 1) select 0) spawn daylight_fnc_interactionRestrainToggle;
	};
};

"daylight_arrPVTicket" addPublicVariableEventHandler {
	if (((_this select 1) select 1) == player) then {
		[(_this select 1) select 1, (_this select 1) select 2, (_this select 1) select 3] call daylight_fnc_interactionOpenPayTicketUI;
	};
};

"daylight_arrPVTicketReturn" addPublicVariableEventHandler {
	if (((_this select 1) select 0) == player) then {
		(_this select 1) call daylight_fnc_interactionHandleTicketResponse;
	};
};

"daylight_arrPVSwitchMove" addPublicVariableEventHandler {
	((_this select 1) select 0) switchMove ((_this select 1) select 1);
};

"daylight_arrPVEnableSimulation" addPublicVariableEventHandler {
	((_this select 1) select 0) enableSimulation ((_this select 1) select 1);
};

"daylight_arrPVSeizeIllegalItems" addPublicVariableEventHandler {
	if (((_this select 1) select 1) == player) then {
		((_this select 1) select 0) call daylight_fnc_interactionSeizeIllegalItems;
	};
};

"daylight_arrPVJailPlayer" addPublicVariableEventHandler {
	if (((_this select 1) select 1) == player) then {
		[((_this select 1) select 0), ((_this select 1) select 2)] call daylight_fnc_jailJailPlayer;
	};
};

"daylight_arrPVAllowDamage" addPublicVariableEventHandler {
	((_this select 1) select 0) allowDamage ((_this select 1) select 1)
};

"daylight_arrPVShoutSend" addPublicVariableEventHandler {
	(_this select 1) call daylight_fnc_shoutReceive;
};

"daylight_arrPVMobilePhoneMessage" addPublicVariableEventHandler {
	if (((_this select 1) select 1) == player) then {
		[(_this select 1) select 2, (_this select 1) select 3] spawn daylight_fnc_mobilePhoneReceiveMessage;
	};
};

/*
	Description:	Exec code for clients + server
	Args:			arr [any args, code code]
	Return:			nothing
*/
daylight_fnc_networkExecGlobal = {
	daylight_arrPVExecGlobal = _this;
	publicVariable "daylight_arrPVExecGlobal";

	(_this select 0) call (_this select 1);
};

/*
	Description:	Exec code for server
	Args:			arr [any args, code code]
	Return:			nothing
*/
daylight_fnc_networkExecServer = {
	daylight_arrPVExecServer = _this;
	publicVariable "daylight_arrPVExecServer";

	if (isServer) then {
		(_this select 0) call (_this select 1);
	};
};

/*
	Description:	Exec code for clients
	Args:			arr [any args, code code]
	Return:			nothing
*/
daylight_fnc_networkExecClient = {
	daylight_arrPVExecClient = _this;
	publicVariable "daylight_arrPVExecClient";

	if (!isDedicated) then {
		(_this select 0) call (_this select 1);
	};
};

/*
	Description:	Exec code for specific client
	Args:			arr [any args, code code]
	Return:			nothing
*/
daylight_fnc_networkExecPlayer = {
	daylight_arrPVExecPlayer = _this;
	publicVariable "daylight_arrPVExecPlayer";

	if ((_this select 0) == player) then {
		(_this select 1) call (_this select 2);
	};
};

/*
	Description:	Broadcasted vehicle lock/unlock
	Args:			arr [veh vehicle, int locked-status]
	Return:			nothing
*/
daylight_fnc_networkLockVehicle = {
	daylight_arrPVLockVehicle = _this;
	publicVariable "daylight_arrPVLockVehicle";

	(_this select 0) lock (_this select 1);
};

/*
	Description:	Broadcast say3D-command
	Args:			arr [veh source, str ClassName]
	Return:			nothing
*/
daylight_fnc_networkSay3D = {
	daylight_arrPVSay3D = _this;
	publicVariable "daylight_arrPVSay3D";

	(_this select 0) say3D (_this select 1);
};

/*
	Description:	Make bank transfer
	Args:			arr [veh receiver, veh sender, i amount]
	Return:			nothing
*/
daylight_fnc_networkMakeBankTransfer = {
	daylight_arrPVBankTransfer = _this;
	publicVariable "daylight_arrPVBankTransfer";
};

/*
	Description:	Body search DO
	Args:			veh player to search
	Return:			nothing
*/
daylight_fnc_networkBodySearchDo = {
	daylight_arrPVBodySearchDo = [player, _this];

	publicVariable "daylight_arrPVBodySearchDo";
};

/*
	Description:	Body search SEND to DOer after DO
	Args:			veh doer
	Return:			nothing
*/
daylight_fnc_networkBodySearchReturn = {
	daylight_arrPVBodySearchReturn = [_this, player, daylight_arrInventory];

	publicVariable "daylight_arrPVBodySearchReturn";
};

/*
	Description:	Restrain
	Args:			veh player to restrain
	Return:			nothing
*/
daylight_fnc_networkRestrainPlayer = {
	daylight_arrPVRestrain = [player, _this];

	publicVariable "daylight_arrPVRestrain";
};

/*
	Description:	Give ticket
	Args:			arr [veh player to give ticket to, i amount, str reason]
	Return:			nothing
*/
daylight_fnc_networkGiveTicket = {
	_iAmount = (_this select 1);
	if (_iAmount > daylight_cfg_iMaxIntValue) then {
		_iAmount = daylight_cfg_iMaxIntValue;
	};

	if (_iAmount != 0) then {
		daylight_arrPVTicket = [player, _this select 0, _iAmount, _this select 2];
		publicVariable "daylight_arrPVTicket";
	};
};

/*
	Description:	Give ticket
	Args:			arr [veh player to give ticket response to, b pay]
	Return:			nothing
*/
daylight_fnc_networkReturnTicket = {
	daylight_arrPVTicketReturn = _this;
	publicVariable "daylight_arrPVTicketReturn";
};

/*
	Description:	Switch move
	Args:			arr [veh to animate, str animation]
	Return:			nothing
*/
daylight_fnc_networkSwitchMove = {
	daylight_arrPVSwitchMove = _this;
	publicVariable "daylight_arrPVSwitchMove";

	(_this select 0) switchMove (_this select 1);
};

/*
	Description:	Enable/disable simulation
	Args:			arr [veh to disable/enable simulation from, b enabled]
	Return:			nothing
*/
daylight_fnc_networkEnableSimulation = {
	daylight_arrPVEnableSimulation = _this;
	publicVariable "daylight_arrPVEnableSimulation";

	(_this select 0) enableSimulation (_this select 1);
};

/*
	Description:	Seize illegal items
	Args:			veh from
	Return:			nothing
*/
daylight_fnc_networkSeizeIllegalItems = {
	daylight_arrPVSeizeIllegalItems = [player, _this];
	publicVariable "daylight_arrPVSeizeIllegalItems";

	// Show notification
	[localize "STR_INTERACTION_MENU_TITLE", format[localize "STR_INTERACTION_MENU_ILLEGALITEMSREMOVED", ([_this, format["arrCharacterData%1", _this call daylight_fnc_returnSideStringForSavedVariables], ["", ""]] call daylight_fnc_loadVar) select 0, name(_this)], true] call daylight_fnc_showHint;
};

/*
	Description:	Jail player
	Args:			arr [veh to jail, i time]
	Return:			nothing
*/
daylight_fnc_networkJailPlayer = {
	daylight_arrPVJailPlayer = [player, _this select 0, _this select 1];
	publicVariable "daylight_arrPVJailPlayer";
};

/*
	Description:	Global allowDamage
	Args:			arr [veh vehicle, b allowDamage]
	Return:			nothing
*/
daylight_fnc_networkAllowDamage = {
	daylight_arrPVAllowDamage = _this;
	publicVariable "daylight_arrPVAllowDamage";
};

/*
	Description:	Send shout
	Args:			str shout text
	Return:			nothing
*/
daylight_fnc_networkShoutSend = {
	daylight_arrPVShoutSend = [player, _this];
	publicVariable "daylight_arrPVShoutSend";

	daylight_arrPVShoutSend call daylight_fnc_shoutReceive;
};

/*
	Description:	Send mobile phone message
	Args:			arr [veh sender, veh target, str name, str message]
	Return:			nothing
*/
daylight_fnc_networkMobilePhoneSendMessage = {
	daylight_arrPVMobilePhoneMessage = _this;
	publicVariable "daylight_arrPVMobilePhoneMessage";
};

/*
	Description:	Handle player state
	Args:			arr [veh player, [i hands up, i restrained, i jailed]]
	Return:			nothing

	Notes:			-1 as input will not change current value
*/
daylight_fnc_handlePlayerState = {
	_arrOutput = [];

	for "_i" from 0 to ((count(_this select 1)) - 1) do {
		_iValue = (_this select 1) select _i;
		if (((_this select 1) select _i) == -1) then {
			_iValue = ((_this select 0) getVariable "daylight_arrState") select _i;
		};

		_arrOutput set [_i, _iValue];
	};

	(_this select 0) setVariable ["daylight_arrState", _arrOutput, true];
};