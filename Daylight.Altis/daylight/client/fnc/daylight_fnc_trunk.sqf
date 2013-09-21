/*
	Description:	Trunk functions
	Author:			qbt
*/

// Initialize default variables
daylight_vehCurrentTrunk = objNull;

/*
	Description:	Check if we are trying to put/take more than we have FROM TRUNK
	Args:			arr [int item id, int amount]
	Return:			int input (or int max)
*/
daylight_fnc_trunkCheckAmount = {
	_iItemID = (_this select 0);
	_iAmount = round(_this select 1);

	// Get vehicle trunk
	_arrTrunk = daylight_vehCurrentTrunk getVariable ["daylight_arrTrunk", []];

	// Make sure amount >= 1
	if (_iAmount >= 1) then {
		// daylight_cfg_iMaxIntValue is max amount we can accurately handle
		if (_iAmount <= daylight_cfg_iMaxIntValue) then {
			// Get item position in array for if (if exists)
			_iItemInInventoryPos = [_arrTrunk, _iItemID] call daylight_fnc_findVariableInNestedArray;

			// Check if item is in inventory
			if (_iItemInInventoryPos != -1) then {
				// Get item array (contains id and amount)
				_arrInventoryItemArray = (_arrTrunk select _iItemInInventoryPos);

				// Check if we're trying to drop more than we have (remove item from array if we have 0 of that item)
				if ((_arrInventoryItemArray select 1) <= _iAmount) then {
					// Drop amount is all we have
					_iAmount = (_arrInventoryItemArray select 1);
				};
			};
		} else {
			_iAmount = daylight_cfg_iMaxIntValue;
		};
	};

	_iAmount
};

/*
	Description:	Removes item from trunk
	Args:			arr [int item id, int amount]
	Return:			nothing
*/
daylight_fnc_trunkRemoveFrom = {
	// Get parameters
	_iItemID = (_this select 0);
	// Round the value so we don't remove decimal amount
	_iAmount = round(_this select 1);
	// Get vehicle trunk
	_arrTrunk = daylight_vehCurrentTrunk getVariable ["daylight_arrTrunk", []];

	// Make sure amount >= 1
	if (_iAmount >= 1) then {
		// Get item position in array for if (if exists)
		_iItemInInventoryPos = [_arrTrunk, _iItemID] call daylight_fnc_findVariableInNestedArray;

		// Check if item is in inventory
		if (_iItemInInventoryPos != -1) then {
			// Get item array (contains id and amount)
			_arrInventoryItemArray = (_arrTrunk select _iItemInInventoryPos);

			// Check if we're trying to remove more than we have (remove item from array if we have 0 of that item)
			if ((_arrInventoryItemArray select 1) <= _iAmount) then {
				// Make value -1 and remove it (we need to make the value something else than an array, -1 will do fine)
				_arrTrunk set [_iItemInInventoryPos, -1];

				// Remove -1
				_arrTrunk = _arrTrunk - [-1];
			} else {
				// Calculate new amount
				_iNewAmount = ((_arrInventoryItemArray select 1) - _iAmount);

				// Modify array to new amount
				_arrTrunk set [_iItemInInventoryPos, [_iItemID, _iNewAmount]];
			};
		};

		// Update trunk
		daylight_vehCurrentTrunk setVariable ["daylight_arrTrunk", _arrTrunk, true];
	};
};

/*
	Description:	Drop item from trunk (when vehicle is destroyed)
	Args:			arr [obj vehicle, int item id, int amount]
	Return:			nothing
*/
daylight_fnc_trunkDropItem = {
	_iItemID = (_this select 1);
	_iAmount = round(_this select 2);

	_iDropAmount = [_iItemID, _iAmount] call daylight_fnc_invCheckAmount;

	// Create object in world and add action
	_strClassname = "";

	// If item is special, use defined model
	_iIndex = [daylight_cfg_arrSpecialItems, _iItemID] call daylight_fnc_findVariableInNestedArray;
	if (_iIndex != -1) then {
		_strClassname = ((daylight_cfg_arrSpecialItems select _iIndex) select 1);
	} else {
		_strClassname = daylight_cfg_strDefaultItemClassName;
	};

	// Add action
	_iMaxSpread = 4;
	_arrPos = [((((getPosASL (_this select 0)) select 0) + 1 + (random _iMaxSpread)) - (random _iMaxSpread)), ((((getPosASL (_this select 0)) select 1) + 1 + (random _iMaxSpread)) - (random _iMaxSpread)), ((getPosASL (_this select 0)) select 2)];
	[[_strClassname, _arrPos, _iItemID, _iDropAmount], {_this call daylight_fnc_dropItemCreateObjectASL}] call daylight_fnc_execClient;
};

/*
	Description:	Put item in trunk
	Args:			arr [int item id, int amount]
	Return:			nothing
*/
daylight_fnc_trunkPutIn = {
	closeDialog 0;

	// Get parameters
	_iItemID = (_this select 0);
	// Round the value so we don't remove decimal amount
	_iAmount = round(_this select 1);
	_iRealAmount = [_iItemID, _iAmount] call daylight_fnc_invCheckAmount;
	// Get vehicle trunk
	_arrTrunk = daylight_vehCurrentTrunk getVariable ["daylight_arrTrunk", []];

	// Remove put item(s) from inventory
	[_iItemID, _iRealAmount] call daylight_fnc_invRemoveItem;

	// Make sure amount >= 1
	if (_iRealAmount >= 1) then {
		// Get item position in array for if (if exists)
		_iItemInInventoryPos = [_arrTrunk, _iItemID] call daylight_fnc_findVariableInNestedArray;

		// Check if item is in inventory, don't add it again but add to the amount
		if (_iItemInInventoryPos != -1) then {
			// Get item array (contains id and amount)
			_arrInventoryItemArray = (_arrTrunk select _iItemInInventoryPos);

			// Calculate new amount
			_iNewAmount = ((_arrInventoryItemArray select 1) + _iRealAmount);

			// Modify array to new amount
			_arrTrunk set [_iItemInInventoryPos, [_iItemID, _iNewAmount]];
		} else {
			// Add item to inventory
			_arrTrunk set [(count _arrTrunk), [_iItemID, _iRealAmount]];
		};
	};

	// Update vehicle trunk
	daylight_vehCurrentTrunk setVariable ["daylight_arrTrunk", _arrTrunk, true];
};

/*
	Description:	Take item from trunk
	Args:			arr [int item id, int amount]
	Return:			nothing
*/
daylight_fnc_trunkTakeFrom = {
	closeDialog 0;

	_iItemID = (_this select 0);
	_iAmount = round(_this select 1);
	_iRealAmount = [_iItemID, _iAmount] call daylight_fnc_trunkCheckAmount;

	// Remove dropped item(s) from inventory
	[_iItemID, _iRealAmount] call daylight_fnc_trunkRemoveFrom;
	[_iItemID, _iRealAmount] call daylight_fnc_invAddItem;
};

/*
	Description:	Open trunk UI
	Args:			veh trunk
	Return:			nothing
*/
daylight_fnc_trunkOpenUI = {
	if (!dialog) then {
		createDialog "Trunk";

		// Set current vehicle
		daylight_vehCurrentTrunk = _this;

		// Spawn loop that updates UI
		[] spawn daylight_fnc_trunkUpdateUI;

		// Update current carried weight
		ctrlSetText[1001, format["Items (%1/%2kg)", daylight_iInventoryWeight, daylight_cfg_iInvMaxCarryWeight]];

		// Populate inv item list
		for "_i" from 0 to (count(daylight_arrInventory) - 1) do {
			// Get item ID and amount from the current array
			_iItemID = (daylight_arrInventory select _i) select 0;
			_iItemAmount = (daylight_arrInventory select _i) select 1;

			// Get item text
			_strItemText = ((_iItemID call daylight_fnc_invIDToStr) select 0);

			// Different text if the amount is more than 1
			if (_iItemAmount != 1) then {
				_strItemText = format["%1 (%2)", _strItemText, _iItemAmount];
			};

			// Add item to list
			lbAdd[1500, _strItemText];

			// Attach item ID data to lbItem
			lbSetData[1500, _i, str(_iItemID)];

			// If item is in illegal ID's range, set text color to red
			if ((_iItemID >= (daylight_cfg_arrInvIllegalIDRange select 0)) && (_iItemID <= (daylight_cfg_arrInvIllegalIDRange select 1))) then {
				lbSetColor[1500, _i, [1, 0, 0, 1]];
			};
		};

		// Populate trunk item list
		_arrTrunk = _this getVariable "daylight_arrTrunk";
		for "_i" from 0 to (count(_arrTrunk) - 1) do {
			// Get item ID and amount from the current array
			_iItemID = (_arrTrunk select _i) select 0;
			_iItemAmount = (_arrTrunk select _i) select 1;

			// Get item text
			_strItemText = ((_iItemID call daylight_fnc_invIDToStr) select 0);

			// Different text if the amount is more than 1
			if (_iItemAmount != 1) then {
				_strItemText = format["%1 (%2)", _strItemText, _iItemAmount];
			};

			// Add item to list
			lbAdd[1501, _strItemText];

			// Attach item ID data to lbItem
			lbSetData[1501, _i, str(_iItemID)];

			// If item is in illegal ID's range, set text color to red
			if ((_iItemID >= (daylight_cfg_arrInvIllegalIDRange select 0)) && (_iItemID <= (daylight_cfg_arrInvIllegalIDRange select 1))) then {
				lbSetColor[1501, _i, [1, 0, 0, 1]];
			};
		};
	};
};

/*
	Description:	Update UI
	Args:			int lbCurSel OR nothing
	Return:			nothing
*/
daylight_fnc_trunkUpdateUI = {
	if (count _this != 0) then {
		_iItemSelected = parseNumber((_this select 0) lbData (_this select 1));

		// Update description
		ctrlSetText [1004, format["%1", ((_iItemSelected call daylight_fnc_invIDToStr) select 1)]];

		if (true) exitWith {};
	};

	while {daylight_bDialogTrunkOpen} do {
		// Update button texts
		if ((lbCurSel 1500) != -1) then {
			_iProfit = [parseNumber(lbData [1500, lbCurSel 1500]), parseNumber(ctrlText 1400)] call daylight_fnc_shopCalculateTotalProfit;
			if (_iProfit > daylight_cfg_iMaxIntValue) then {
				_iProfit = daylight_cfg_iMaxIntValue;
			};

			(uiNamespace getVariable "daylight_dsplActive" displayCtrl 1700) ctrlSetText (format[localize "STR_TRUNK_BUTTON_PUT", [parseNumber(lbData [1500, lbCurSel 1500]), parseNumber(ctrlText 1400)] call daylight_fnc_invGetItemWeight, localize "STR_WEIGHT_UNIT"]);
		} else {
			if ((lbSize 1500) == 0) then {
				(uiNamespace getVariable "daylight_dsplActive" displayCtrl 1700) ctrlSetText (format[localize "STR_TRUNK_BUTTON_PUT", 0, localize "STR_WEIGHT_UNIT"]);
				ctrlEnable [1700, false];
			} else {
				lbSetCurSel [1500, 0];
			};
		};

		if ((lbCurSel 1501) != -1) then {
			_iCost = [parseNumber(lbData [1501, lbCurSel 1501]), parseNumber(ctrlText 1401)] call daylight_fnc_shopCalculateTotalPrice;
			if (_iCost > daylight_cfg_iMaxIntValue) then {
				_iCost = daylight_cfg_iMaxIntValue;
			};

			(uiNamespace getVariable "daylight_dsplActive" displayCtrl 1701) ctrlSetText (format[localize "STR_TRUNK_BUTTON_TAKE", [parseNumber(lbData [1501, lbCurSel 1501]), parseNumber(ctrlText 1401)] call daylight_fnc_invGetItemWeight, localize "STR_WEIGHT_UNIT"]);
		} else {
			if ((lbSize 1501) == 0) then {
				(uiNamespace getVariable "daylight_dsplActive" displayCtrl 1701) ctrlSetText (format[localize "STR_TRUNK_BUTTON_TAKE", 0, localize "STR_WEIGHT_UNIT"]);
				ctrlEnable [1701, false];
			} else {
				lbSetCurSel [1501, 0];
			};
		};

		sleep 0.025;
	};

	if (true) exitWith {};
};