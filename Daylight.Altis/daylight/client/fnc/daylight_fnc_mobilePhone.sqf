/*
	Description:	Mobile phone functions
	Author:			qbt
*/

/*
	Description:	Open mobile phone UI
	Args:			nothing
	Return:			nothing
*/
daylight_fnc_mobilePhoneOpenUI = {
	if (!dialog) then {
		createDialog "MobilePhone";

		// Populate player list
		for "_i" from 0 to ((count playableUnits) - 1) do {
			if ((playableUnits select _i) != player) then {
				lbAdd [2100, name((playableUnits select _i))];
				lbSetData [2100, _i, str _i];
			};
		};

		if ((lbSize 2100) > 0) then {
			while {(lbCurSel 2100) == -1} do {
				lbSetCurSel [2100, 0];
			};
		} else {
			ctrlEnable [1700, false];
		};

		// Add options for anonymous and not anonymous sending
		lbAdd [2101, "Send with name"]; // TO-DO: Localize
		lbAdd [2101, "Send anonymously"];

		while {(lbCurSel 2101) == -1} do {
			lbSetCurSel [2101, 0];
		};

		// Populate messages list
		_arrMessages = profileNamespace getVariable "daylight_arrMobilePhoneMessages";

		for "_i" from 0 to ((count _arrMessages) - 1) do {
			lbAdd [1500, format["Message from %1", (_arrMessages select _i) select 0]];

			// Mark read messages with grey
			if (!((_arrMessages select _i) select 2)) then {
				lbSetColor [1500, _i, [0.5, 0.5, 0.5, 0.5]];
			};
		};

		if ((lbSize 1500) > 0) then {
			while {(lbCurSel 1500) == -1} do {
				lbSetCurSel [1500, 0];
			};
		} else {
			ctrlEnable [1701, false];

			lbAdd [1500, "No messages to show."]; // TO-DO: Localize
		};
	};
};

/*
	Description:	Receive message
	Args:			arr [str sender name, str message]
	Return:			nothing
*/
daylight_fnc_mobilePhoneReceiveMessage = {
	_arrMessages = profileNamespace getVariable "daylight_arrMobilePhoneMessages";
	_arrMessages set [count _arrMessages, [_this select 0, _this select 1, true]];

	profileNamespace setVariable ["daylight_arrMobilePhoneMessages", _arrMessages];
	saveProfileNamespace;

	if (true) exitWith {};
};

/*
	Description:	Send message
	Args:			arr [veh to, str message, i combobox anonymous-selected index]
	Return:			nothing
*/
daylight_fnc_mobilePhoneSendMessage = {
	closeDialog 0;

	_strName = "Anonymous"; // TO-DO: Localize
	if ((_this select 2) == 0) then {
		_strName = name player;
	};

	[player, (_this select 0), _strName, (_this select 1)] call daylight_fnc_networkMobilePhoneSendMessage;
};

/*
	Description:	Read message
	Args:			i index from messages array
	Return:			nothing
*/
daylight_fnc_mobilePhoneReadMessage = {
	closeDialog 0;

	_arrMessages = profileNamespace getVariable "daylight_arrMobilePhoneMessages";

	[format["Message from %1", (_arrMessages select _this) select 0], (_arrMessages select _this) select 1] call daylight_fnc_showNotificationWindow;

	// Mark as read
	_arrMessages set [_this, [(_arrMessages select _this) select 0, (_arrMessages select _this) select 1, false]];
	profileNamespace setVariable ["daylight_arrMobilePhoneMessages", _arrMessages];
	saveProfileNamespace;
};