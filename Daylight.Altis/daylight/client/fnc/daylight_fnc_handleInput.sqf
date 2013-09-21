/*
	Description:	Handle keyboard and mouse input
	Author:			qbt
*/

// Initialize last input time variable(s), we can use this to stop unwanted behaviour if key is kept down.
daylight_iLastInputTime = 0;
daylight_iLastLockTime = 0;
daylight_iLastSurrenderTime = 0;

daylight_arrInputWhitelist = toArray daylight_cfg_strInputWhitelist;

// Handle main KeyDown-UI-EH
daylight_fnc_handleKeyDown = {
	_bDisableDefaultAction = false;

	switch (true) do {
		// Catch IngamePause to disable respawn button
		case ((_this select 1) in (actionKeys "IngamePause")) : {
			_bDisableDefaultAction = false;

			if ((time - daylight_iLastInputTime) >= 0.1) then {
				[] spawn daylight_fnc_disableRespawnButton;
			};
		};

		// Disable command mode
		case ((_this select 1) in (actionKeys "ForceCommandingMode")) : {
			_bDisableDefaultAction = true;
		};

		// Disable diary
		case ((_this select 1) in (actionKeys "Diary")) : {
			_bDisableDefaultAction = true;
		};

		// Disable vault, salute and sit if restrained or surrendered
		case (((_this select 1) in (actionKeys "GetOver")) || ((_this select 1) in (actionKeys "Salute")) || ((_this select 1) in (actionKeys "SitDown"))) : {
			if (daylight_bRestrained && daylight_bSurrendered) then {
				_bDisableDefaultAction = true;
			};
		};

		// E - Interact
		case ((_this select 1) == 0x12) : {
			if (((player distance cursorTarget) < daylight_cfg_iMaxDistanceFromInteractedUnit) && !daylight_bJailed) then {
				// Merchant
				if ((daylight_arrMerchants find cursorTarget) != -1) then {
					cursorTarget call daylight_fnc_shopOpenUI;
				};

				// Impound officer
				if ((daylight_arrImpoundOfficers find cursorTarget) != -1) then {
					cursorTarget call daylight_fnc_impoundReturnOpenUI;
				};

				// Impound officer
				if ((daylight_arrLicenseSellers find cursorTarget) != -1) then {
					cursorTarget call daylight_fnc_licensesBuyOpenUI;
				};

				// Player
				if (isPlayer cursorTarget) then {
					cursorTarget call daylight_fnc_interactionOpenUI;
				};
			};
		};

		// I - Introduce self
		case ((_this select 1) == 0x17) : {
			_bDisableDefaultAction = false;

			if ((isPlayer cursorTarget) && ((side player) == civilian) && (alive cursorTarget)) then {
				_bDisableDefaultAction = true;

				if (((time - daylight_iLastInputTime) >= 0.5) && ((cursorTarget distance player) <= 5)) then {
					cursorTarget call daylight_fnc_interactionIntroduceSelf;
				};
			};
		};

		// L - Toggle vehicle lock status
		case ((_this select 1) == 0x26) : {
			_bDisableDefaultAction = true;
			if ((time - daylight_iLastLockTime) >= 0.5) then {
				if ((!(isNull cursorTarget) || ((vehicle player) != player))) then {
					// Determine vehicle we are trying to lock/unlock
					_vehTarget = cursorTarget;

					if ((vehicle player) != player) then {
						_vehTarget = vehicle player;
					};

					// Make sure target is a vehicle and not a class of "Man"
					if ((_vehTarget isKindOf "AllVehicles") && !(_vehTarget isKindOf "Man") && (alive _vehTarget)) then {
						// Check if player has keys for vehicle
						if ([player, _vehTarget] call daylight_fnc_hasKeysFor) then {
							// If yes, toggle lock status
							[_vehTarget, _vehTarget call daylight_fnc_toggledVehicleLockedNumber] call daylight_fnc_networkLockVehicle;
						} else {
							// Show info about having no keys
							[localize "STR_ACTION_NO_KEYS"] call daylight_fnc_showActionMsg;
						};
					};

					daylight_iLastLockTime = time;
				};
			};
		};

		// T - Whistle/Trunk
		case ((_this select 1) == 0x14) : {
			_bDisableDefaultAction = true;

			if (((vehicle player) != player) && (driver(vehicle(player)) == player)) then {
				_vehTarget = vehicle player;

				if ([player, _vehTarget] call daylight_fnc_hasKeysFor) then {
					// If yes, open trunk
					_vehTarget call daylight_fnc_trunkOpenUI;
				} else {
					// Show info about having no keys
					[localize "STR_ACTION_NO_KEYS"] call daylight_fnc_showActionMsg;
				};
			} else {
				// Whistle
				player call daylight_fnc_whistle;
			};
		};

		// Spacebar
		case ((_this select 1) == 0x39) : {
			_bDisableDefaultAction = true;

			if (daylight_bReadyToRespawn) then {
				call daylight_fnc_respawn;
			};
		};

		// TAB - Inventory
		case ((_this select 1) == 0x0F) : {
			_bDisableDefaultAction = true;

			if (!(_this select 2)) then {
				[] call daylight_fnc_invOpenUI;
			};
		};

		// F-keys
		case ((_this select 1) == 0x3B) : {
			_bDisableDefaultAction = true;

			false call daylight_fnc_bankOpenUI;
		};

		case (([0x3B, 0x3C, 0x3D, 0x3E, 0x3F, 0x40, 0x41, 0x42, 0x43, 0x44, 0x57, 0x58] find (_this select 1)) != -1) : {
			_bDisableDefaultAction = true;
		};

		// 0 - 9
		// 3 - Surrender
		case ((_this select 1) == 0x04) : {
			_bDisableDefaultAction = true;

			if ((time - daylight_iLastSurrenderTime) >= 0.5) then {
				[] call daylight_fnc_interactionSurrenderToggle;

				daylight_iLastSurrenderTime = time;
			};
		};

		case ((_this select 1) == 0x0B) : {
			_bDisableDefaultAction = true;

			[] call daylight_fnc_shoutEditOpenUI;
		};

		case ((_this select 1) == 0x06) : {
			_bDisableDefaultAction = true;

			0 call daylight_fnc_shoutSend;
		};

		case ((_this select 1) == 0x07) : {
			_bDisableDefaultAction = true;

			1 call daylight_fnc_shoutSend;
		};

		case ((_this select 1) == 0x08) : {
			_bDisableDefaultAction = true;

			2 call daylight_fnc_shoutSend;
		};

		case ((_this select 1) == 0x09) : {
			_bDisableDefaultAction = true;

			3 call daylight_fnc_shoutSend;
		};

		case ((_this select 1) == 0x0A) : {
			_bDisableDefaultAction = true;

			4 call daylight_fnc_shoutSend;
		};

		case ((_this select 1) == 0x05) : {
			_bDisableDefaultAction = true;

			[] call daylight_fnc_mobilePhoneOpenUI;
		};

		case (([0x02, 0x03, 0x04] find (_this select 1)) != -1) : {
			_bDisableDefaultAction = true;
		};
	};

	daylight_iLastInputTime = time;

	_bDisableDefaultAction
};

/*
	Description:	Handle custom dialog KeyDown-UI-EH to disable user escape from dialog via keyboard
	Args:			arr [(from UIEH)]
	Return:			nothing
*/
daylight_fnc_handleKeyDownDisableDialogExitByKeyboard = {
	_bDisableDefaultAction = false;

	if ((_this select 1) in (actionKeys "IngamePause")) then {
		_bDisableDefaultAction = true;
	};

	_bDisableDefaultAction
};

/*
	Description:	Limit RscEdit str input length
	Args:			arr [ctrl ctrl, int maxlen]
	Return:			nothing
*/
daylight_fnc_limitRscEditInputLen = {
	_arrText = toArray (ctrlText (_this select 0));

	for "_i" from 0 to ((count _arrText) - 1) do {
		if ((daylight_arrInputWhitelist find (_arrText select _i)) == -1) then {
			_arrText set [_i, -1];
		};
	};

	_arrText = _arrText - [-1];
	_strText = toString _arrText;

	if ((_strText call daylight_fnc_strLen) > (_this select 1)) then {
		(_this select 0) ctrlSetText ([_strText, (_this select 1)] call daylight_fnc_strResize);
	} else {
		(_this select 0) ctrlSetText _strText;
	};
};

// Spawn code that adds our UI-EH's
[] spawn {
	disableSerialization;

	// Wait until main display becomes active
	waitUntil {!(isNull (findDisplay 46))};

	// Add UI-EH's
	(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call daylight_fnc_handleKeyDown"];

	if (true) exitWith {};
};

/*
	Description:	Handle inventory exit with TAB key
	Args:			arr [(from UIEH)]
	Return:			nothing
*/
daylight_fnc_handleKeyDownInventoryExit = {
	_bDisableDefaultAction = false;

	if ((_this select 1) == 0x0F) then {
		_bDisableDefaultAction = true;

		closeDialog 0;
	};

	_bDisableDefaultAction
};