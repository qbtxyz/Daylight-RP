/*
	Description:	Inventory functions
	Author:			qbt
*/

// Create player inventory array and default weight carried
daylight_arrInventory = [];
daylight_iInventoryWeight = 0;

// Initialize other variables used by these functions
daylight_bPlayerNears = true;

/*
	Description:	Open Inventory UI
	Args:			nothing
	Return:			nothing
*/
daylight_fnc_invOpenUI = {
	// Make sure no other dialogs are open
	if (!dialog && !daylight_bRespawning && !daylight_bJailed && !daylight_bSurrendered && !daylight_bRestrained && !daylight_bJailed) then {
		createDialog "Inventory";

		// Disable buttons
		ctrlEnable [1700, false];
		ctrlEnable [1701, false];
		ctrlEnable [1702, false];

		// Update current carried weight
		ctrlSetText [1001, format["Items (%1/%2kg)", daylight_iInventoryWeight, daylight_cfg_iInvMaxCarryWeight]];

		// Populate inventory item list from inventory array
		for "_i" from 0 to ((count daylight_arrInventory) - 1) do {
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

		// Populate player list
		// Clear (or create) near players global array that will be used later if items are given to other players
		daylight_arrInventoryNearPlayers = [];

		// Get list of near Man-entities
		_arrNearPlayers = (getPosATL player) nearEntities ["Man", daylight_cfg_iInvMaxGiveDistance];

		// Loop trough that list
		for "_i" from 0 to ((count _arrNearPlayers) - 1) do {
			// Check if entity is a player and is not the player itself
			if ((isPlayer (_arrNearPlayers select _i)) && ((_arrNearPlayers select _i) != player)) then {
				// Variable that determines if player will be added to daylight_arrInventoryNearPlayers list
				_bAddToList = true;

				// Get players name
				_strName = (([(_arrNearPlayers select _i), format["arrCharacterData%1", (_arrNearPlayers select _i) call daylight_fnc_returnSideStringForSavedVariables], ["", ""]] call daylight_fnc_loadVar) select 0);

				// If player is civilian, we need to check if (_arrNearPlayers select _i) has introduced himself to local player
				if ((side (_arrNearPlayers select _i)) == civilian) then {
					if ([(_arrNearPlayers select _i), player] call daylight_fnc_hasIntroducedTo) then {
						_bAddToList = true;
					} else {
						_bAddToList = false;
					}
				};

				if (_bAddToList) then {
					// Add to near players global array
					daylight_arrInventoryNearPlayers set [count daylight_arrInventoryNearPlayers, _arrNearPlayers select _i];

					// Add entry and data to listbox
					lbAdd[1501, _strName];
					lbSetData[1501, _i, str(_i)];
				};
			};
		};
	};
};

/*
	Description:	Returns item name and description from ID
	Args:			int itemID
	Return:			arr [str item name, str item description]
*/
daylight_fnc_invIDToStr = {
	// Get values from stringtable.csv and set them as the return value
	[localize (format["STR_ITEM_%1", _this]), localize (format["STR_ITEM_%1_DESC", _this])]
};

/*
	Description:	Update UI
	Args:			int lbCurSel
	Return:			nothing
*/
daylight_fnc_invUpdateUI = {
	_iItemSelected = parseNumber((_this select 0) lbData (_this select 1));

	// Enable button
	ctrlEnable [1702, true];

	// Check if selected item is usable
	if (vehicle(player) != player) then {
		ctrlEnable [1700, false];
		ctrlEnable [1702, false];
	} else {
		if ((daylight_cfg_arrUnusableItems find _iItemSelected) != -1) then {
			ctrlEnable [1700, false];
		} else {
			ctrlEnable [1700, true];
		};

		if ((daylight_cfg_arrUndroppableItems find _iItemSelected) != -1) then {
			ctrlEnable [1702, false];
		};
	};

	// Update description
	ctrlSetText [1005, format["%1", ((_iItemSelected call daylight_fnc_invIDToStr) select 1)]];
};

/*
	Description:	Return item weight from ID and amount
	Args:			arr [int item id, int amount]
	Return:			int weight
*/
daylight_fnc_invGetItemWeight = {
	// Get values from stringtable.csv and set them as the return value
	_iWeight = ((parseNumber (localize (format["STR_ITEM_%1_WEIGHT", (_this select 0)]))) * (_this select 1));

	if (_iWeight > daylight_cfg_iMaxIntValue) then {
		_iWeight = daylight_cfg_iMaxIntValue;
	};

	_iWeight
};

/*
	Description:	Check if we are trying to drop/give more than we have FROM INVENTORY
	Args:			arr [int item id, int amount]
	Return:			int input (or int max droppable/giveable)
*/
daylight_fnc_invCheckAmount = {
	_iItemID = (_this select 0);
	_iAmount = round(_this select 1);

	// Make sure amount >= 1
	if (_iAmount >= 1) then {
		// daylight_cfg_iMaxIntValue is max amount we can accurately handle
		if (_iAmount <= daylight_cfg_iMaxIntValue) then {
			// Get item position in array for if (if exists)
			_iItemInInventoryPos = [daylight_arrInventory, _iItemID] call daylight_fnc_findVariableInNestedArray;

			// Check if item is in inventory
			if (_iItemInInventoryPos != -1) then {
				// Get item array (contains id and amount)
				_arrInventoryItemArray = (daylight_arrInventory select _iItemInInventoryPos);

				// Check if we're trying to drop more than we have (remove item from array if we have 0 of that item)
				if ((_arrInventoryItemArray select 1) <= _iAmount) then {
					// Drop amount is all we have
					_iAmount = (_arrInventoryItemArray select 1);
				};
			} else {
				_iAmount = 0;
			};
		} else {
			_iAmount = daylight_cfg_iMaxIntValue;
		};
	};

	_iAmount
};

/*
	Description:	Add item to inv (no weight check)
	Args:			arr [int item id, int amount]
	Return:			nothing
*/
daylight_fnc_invAddItem = {
	// Get parameters
	_iItemID = (_this select 0);
	// Round the value so we don't remove decimal amount
	_iAmount = round(_this select 1);

	// Make sure amount >= 1
	if (_iAmount >= 1) then {
		// Get item position in array for if (if exists)
		_iItemInInventoryPos = [daylight_arrInventory, _iItemID] call daylight_fnc_findVariableInNestedArray;

		// Check if item is in inventory, don't add it again but add to the amount
		if (_iItemInInventoryPos != -1) then {
			// Get item array (contains id and amount)
			_arrInventoryItemArray = (daylight_arrInventory select _iItemInInventoryPos);

			// Calculate new amount
			_iNewAmount = ((_arrInventoryItemArray select 1) + _iAmount);

			if (_iNewAmount >= daylight_cfg_iMaxIntValue) then {
				_iNewAmount = daylight_cfg_iMaxIntValue;
			};

			// Modify array to new amount
			daylight_arrInventory set [_iItemInInventoryPos, [_iItemID, _iNewAmount]];
		} else {
			// Add item to inventory
			daylight_arrInventory set [(count daylight_arrInventory), [_iItemID, _iAmount]];
		};
	};
};

/*
	Description:	Add item to inv (with weight check)
	Args:			arr [int item id, int amount]
	Return:			nothing
*/
daylight_fnc_invAddItemWithWeight = {
	// Get parameters
	_iItemID = (_this select 0);
	// Round the value so we don't remove decimal amount
	_iAmount = round(_this select 1);

	// Make sure amount >= 1
	if (_iAmount >= 1) then {
		if ([([_iItemID, _iAmount] call daylight_fnc_invGetItemWeight)] call daylight_fnc_invCheckWeight) then {
			// Get item position in array for if (if exists)
			_iItemInInventoryPos = [daylight_arrInventory, _iItemID] call daylight_fnc_findVariableInNestedArray;

			// Check if item is in inventory, don't add it again but add to the amount
			if (_iItemInInventoryPos != -1) then {
				// Get item array (contains id and amount)
				_arrInventoryItemArray = (daylight_arrInventory select _iItemInInventoryPos);

				// Calculate new amount
				_iNewAmount = ((_arrInventoryItemArray select 1) + _iAmount);

				// Modify array to new amount
				daylight_arrInventory set [_iItemInInventoryPos, [_iItemID, _iNewAmount]];
			} else {
				// Add item to inventory
				daylight_arrInventory set [(count daylight_arrInventory), [_iItemID, _iAmount]];
			};
		} else {
			["You can't carry that much, max weight reached!"] call daylight_fnc_showActionMsg;
		};
	};
};

/*
	Description:	Removes item from inventory
	Args:			arr [int item id, int amount]
	Return:			nothing
*/
daylight_fnc_invRemoveItem = {
	// Get parameters
	_iItemID = (_this select 0);
	// Round the value so we don't remove decimal amount
	_iAmount = round(_this select 1);

	// Make sure amount >= 1
	if (_iAmount >= 1) then {
		// Get item position in array for if (if exists)
		_iItemInInventoryPos = [daylight_arrInventory, _iItemID] call daylight_fnc_findVariableInNestedArray;

		// Check if item is in inventory
		if (_iItemInInventoryPos != -1) then {
			// Get item array (contains id and amount)
			_arrInventoryItemArray = (daylight_arrInventory select _iItemInInventoryPos);

			// Check if we're trying to remove more than we have (remove item from array if we have 0 of that item)
			if ((_arrInventoryItemArray select 1) <= _iAmount) then {
				// Make value -1 and remove it (we need to make the value something else than an array, -1 will do fine)
				daylight_arrInventory set [_iItemInInventoryPos, -1];

				// Remove -1
				daylight_arrInventory = daylight_arrInventory - [-1];
			} else {
				// Calculate new amount
				_iNewAmount = ((_arrInventoryItemArray select 1) - _iAmount);

				// Modify array to new amount
				daylight_arrInventory set [_iItemInInventoryPos, [_iItemID, _iNewAmount]];
			};
		};
		
		// Remove from carried weight
		[-([_iItemID, _iAmount] call daylight_fnc_invGetItemWeight)] call daylight_fnc_invModifyWeight;
	};
};

/*
	Description:	Receive item (when given by another player)
	Args:			arr [int item id, int amount, bool show message]
	Return:			nothing
*/
daylight_fnc_receiveItem = {
	if ([([(_this select 1), (_this select 2)] call daylight_fnc_invGetItemWeight)] call daylight_fnc_invCheckWeight) then {
		[(_this select 1), (_this select 2)] call daylight_fnc_invAddItem;
		[([(_this select 1), (_this select 2)] call daylight_fnc_invGetItemWeight)] call daylight_fnc_invModifyWeight;

		if ((_this select 3)) then {
			[format["You received %1!", ((_this select 1) call daylight_fnc_invIDToStr) select 0]] call daylight_fnc_showActionMsg;
		};
	} else {
		[(_this select 0), [player, (_this select 1), (_this select 2), false], {_this call daylight_fnc_receiveItem}] call daylight_fnc_execPlayer;
		["You can't carry that much, max weight reached!", 1] call daylight_fnc_showActionMsg;
	};
};

/*
	Description:	Give item to another player
	Args:			arr [obj target, int item id, int amount]
	Return:			nothing
*/
daylight_fnc_giveItem = {
	closeDialog 0;

	_iItemID = (_this select 1);
	_iAmount = round(_this select 2);

	_iGiveAmount = [_iItemID, _iAmount] call daylight_fnc_invCheckAmount;
	[_iItemID, _iGiveAmount] call daylight_fnc_invRemoveItem;
	[-([_iItemID, _iAmount] call daylight_fnc_invGetItemWeight)] call daylight_fnc_invModifyWeight;

	// Replace
	[(_this select 0), [player, (_this select 1), _iGiveAmount, true], {_this call daylight_fnc_receiveItem}] call daylight_fnc_execPlayer;
};

/*
	Description:	Use item
	Args:			arr [int item id, int amount]
	Return:			nothing
*/
daylight_fnc_useItem = {
	closeDialog 0;

	_hSQF = _this execVM (format["daylight\client\items\%1", (localize format["STR_ITEM_%1_SCRIPT", (_this select 0)])]);
};

/*
	Description:	Drop item
	Args:			arr [int item id, int amount]
	Return:			nothing
*/
daylight_fnc_dropItem = {
	closeDialog 0;

	_iItemID = (_this select 0);
	_iAmount = round(_this select 1);

	_iDropAmount = [_iItemID, _iAmount] call daylight_fnc_invCheckAmount;

	// Remove dropped item(s) from inventory
	[_iItemID, _iDropAmount] call daylight_fnc_invRemoveItem;

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
	_iMaxSpread = 1.5;
	_arrPos = [((((getPosASL player) select 0) + (random _iMaxSpread)) - (random _iMaxSpread)), ((((getPosASL player) select 1) + (random _iMaxSpread)) - (random _iMaxSpread)), ((getPosASL player) select 2)];
	
	// Replace
	[[_strClassname, _arrPos, _iItemID, _iDropAmount], {_this call daylight_fnc_dropItemCreateObjectASL}] call daylight_fnc_execClient;

	// Show "dropped" message
	[format["You dropped %1 %2", _iDropAmount, ((_this select 0) call daylight_fnc_invIDToStr) select 0]] call daylight_fnc_showActionMsg;
};

/*
	Description:	Creates object in world that you can pick up
	Args:			arr [arr pos, int spread, int item id, int amount]
	Return:			nothing
*/
daylight_fnc_createItemWorld = {
	_iItemID = (_this select 2);
	_iAmount = round(_this select 3);

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
	_iMaxSpread = (_this select 1);
	_arrPos = [(((((_this select 0)) select 0) + (random _iMaxSpread)) - (random _iMaxSpread)), (((((_this select 0)) select 1) + (random _iMaxSpread)) - (random _iMaxSpread)), 0];
	
	// Replace
	[[_strClassname, _arrPos, _iItemID, _iAmount], {_this call daylight_fnc_dropItemCreateObject}] call daylight_fnc_execClient;
};

/*
	Description:	Create object for dropped object (above ground level)
	Args:			arr [str classname, arr pos, int item id, int amount]
	Return:			nothing
*/
daylight_fnc_dropItemCreateObject = {
	if (!isDedicated) then {
		_vehItem = (_this select 0) createVehicleLocal [0, 0, 0];
		_vehItem setPos (_this select 1);

		_strAction = "";

		if ((_this select 3) == 1) then {
			_strAction = format["<t color=""#75c2e6"">Take %1</t>", (localize format["STR_ITEM_%1", (_this select 2)])];
		} else {
			_strAction = format["<t color=""#75c2e6"">Take %1 (%2)</t>", (localize format["STR_ITEM_%1", (_this select 2)]), (_this select 3)];
		};

		_vehItem addAction [_strAction, "daylight\client\actions\takeItem.sqf", [(_this select 2), (_this select 3)], 10, true, true, "", "!daylight_bPlayerNears"];

		// Disable simulation
		player reveal _vehItem;
		_vehItem enableSimulation false;
	};
};

/*
	Description:	Create object for dropped object (above sea level)
	Args:			arr [str classname, arr pos, int item id, int amount]
	Return:			nothing
*/
daylight_fnc_dropItemCreateObjectASL = {
	if (!isDedicated) then {
		_vehItem = (_this select 0) createVehicleLocal [0, 0, 0];
		_vehItem setPosASL (_this select 1);

		_strAction = "";

		if ((_this select 3) == 1) then {
			_strAction = format["<t color=""#75c2e6"">Take %1</t>", (localize format["STR_ITEM_%1", (_this select 2)])];
		} else {
			_strAction = format["<t color=""#75c2e6"">Take %1 (%2)</t>", (localize format["STR_ITEM_%1", (_this select 2)]), (_this select 3)];
		};

		_vehItem addAction [_strAction, "daylight\client\actions\takeItem.sqf", [(_this select 2), (_this select 3)], 10, true, true, "", "!daylight_bPlayerNears"];

		// Disable simulation
		player reveal _vehItem;
		_vehItem enableSimulation false;
	};
};

/*
	Description:	Delete local dropped item from other clients
	Args:			arr pos
	Return:			nothing
*/
daylight_fnc_dropItemDeleteObject = {
	if (!isDedicated) then {
		_vehNearestObject = ((nearestObjects [(_this select 0), ["EvMoney", "Suitcase"], 5]) select 0);
		deleteVehicle _vehNearestObject;
	};
};

/*
	Description:	Check if we can add more weight to inventory
	Args:			int weight
	Return:			bool weight reached
*/
daylight_fnc_invCheckWeight = {
	_bRetVal = false;
	_iVal = daylight_iInventoryWeight + (_this select 0);
	
	if (_iVal <= daylight_cfg_iInvMaxCarryWeight) then {
		_bRetVal = true;
	};

	_bRetVal
};

/*
	Description:	Modify inventory weight
	Args:			int weight
	Return:			nothing
*/
daylight_fnc_invModifyWeight = {
	daylight_iInventoryWeight = daylight_iInventoryWeight + (_this select 0);
	
	if (daylight_iInventoryWeight < 0) then {
		daylight_iInventoryWeight = 0;
	};
};

/*
	Description:	Add item id to undroppable items list
	Args:			int item id
	Return:			nothing
*/
daylight_fnc_addUndroppableItem = {
	if (!((_this select 0) in daylight_arrUnDroppableItems)) then {
		daylight_arrUnDroppableItems set [count daylight_arrUnDroppableItems, (_this select 0)];
	};
};

/*
	Description:	Remove item id to undroppable items list
	Args:			int item id
	Return:			nothing
*/
daylight_fnc_removeUnDroppableItem = {
	if ((_this select 0) in daylight_arrUnDroppableItems) then {
		daylight_arrUnDroppableItems = daylight_arrUnDroppableItems - [(_this select 0)];
	};
};