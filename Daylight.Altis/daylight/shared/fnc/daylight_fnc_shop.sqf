/*
	Description:	Shop functions
	Author:			qbt
*/

/*
	Description:	Spawn merchants from cfgShops
	Args:			nothing
	Return:			nothing
*/
daylight_fnc_shopSpawnMerchants = {
	daylight_arrMerchants = [];

	_grpMerchants = createGroup civilian;

	{
		_untMerchant = _grpMerchants createUnit [(_x select 0) select 0, [0, 0, 0], [], 0, "NONE"];

		_untMerchant setVariable ["daylight_arrInitialPos", (_x select 3)];

		_untMerchant enableSimulation false;
		_untMerchant allowDamage false;

		_untMerchant addEventHandler ["HandleDamage", {
			(_this select 0) setVelocity [0, 0, 0];

			_arrPos = (_this select 0) getVariable "daylight_arrInitialPos";

			if (((_this select 0) distance _arrPos) > 5) then {
				(_this select 0) setPosATL ((_this select 0) getVariable "daylight_arrInitialPos");
			};

			(_this select 0) switchMove "";
		}];

		{_untMerchant disableAI _x} forEach ["TARGET", "AUTOTARGET", "MOVE", "ANIM", "FSM"];
		_untMerchant setSkill 0;

		_untMerchant setFace ((_x select 0) select 1);
		_untMerchant addHeadgear ((_x select 0) select 2);
		_untMerchant addGoggles ((_x select 0) select 3);
		_untMerchant addUniform ((_x select 0) select 4);
		_untMerchant addVest ((_x select 0) select 5);

		_untMerchant switchMove "";

		_untMerchant setPos (_x select 4);
		_untMerchant setDir (_x select 5);

		_untMerchant setVariable ["daylight_arrMerchantInfo", [_x select 1, _x select 2, _x select 3, _x select 6], true];

		daylight_arrMerchants set [count daylight_arrMerchants, _untMerchant];
	} forEach daylight_cfg_arrMerchants;

	publicVariable "daylight_arrMerchants";
};

/*
	Description:	Open shop UI
	Args:			veh cursorTarget
	Return:			nothing
*/
daylight_fnc_shopOpenUI = {
	if (!dialog) then {
		createDialog "Shop";

		// Set current merchant
		daylight_vehCurrentMerchant = _this;

		// Spawn loop that updates UI
		[] spawn daylight_fnc_shopUpdateUI;

		// Update main title
		ctrlSetText [1002, (_this getVariable "daylight_arrMerchantInfo") select 0];

		// Update current carried weight
		ctrlSetText [1001, format["Items (%1/%2kg)", daylight_iInventoryWeight, daylight_cfg_iInvMaxCarryWeight]];

		// Populate inv item list
		for "_i" from 0 to (count(daylight_arrInventory) - 1) do {
			// Get item ID and amount from the current array
			_iItemID = (daylight_arrInventory select _i) select 0;
			_iItemAmount = (daylight_arrInventory select _i) select 1;

			// Get item text
			_strItemText = ((_iItemID call daylight_fnc_invIDToStr) select 0);

			// Different text if the amount is more than 1 or -1
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

		// Populate shop item list
		_arrShop = ((_this getVariable "daylight_arrMerchantInfo") select 1);
		for "_i" from 0 to (count(_arrShop) - 1) do {
			// Get item ID and amount from the current array
			_iItemID = (_arrShop select _i) select 0;
			_iItemAmount = (_arrShop select _i) select 1;

			// Get item text
			_strItemText = format["%1 (%2%3) (%4%5)", ((_iItemID call daylight_fnc_invIDToStr) select 0), [_iItemID, 1] call daylight_fnc_shopCalculateTotalPrice, localize "STR_CURRENCY", [_iItemID, 1] call daylight_fnc_invGetItemWeight, localize "STR_WEIGHT_UNIT"];

			// Different text if the amount is more than 1
			if ((_iItemAmount != 1) && (_iItemAmount != -1)) then {
				_strItemText = format["%1 (%2) (%3%4) (%5%6)", ((_iItemID call daylight_fnc_invIDToStr) select 0), _iItemAmount, [_iItemID, 1] call daylight_fnc_shopCalculateTotalPrice, localize "STR_CURRENCY", [_iItemID, 1] call daylight_fnc_invGetItemWeight, localize "STR_WEIGHT_UNIT"];
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
daylight_fnc_shopUpdateUI = {
	if (count _this != 0) then {
		_iItemSelected = parseNumber((_this select 0) lbData (_this select 1));

		// Update description
		ctrlSetText [1004, format["%1", ((_iItemSelected call daylight_fnc_invIDToStr) select 1)]];

		if (true) exitWith {};
	};

	while {daylight_bDialogShopOpen} do {
		// Update button texts
		if ((lbCurSel 1500) != -1) then {
			_iProfit = [parseNumber(lbData [1500, lbCurSel 1500]), parseNumber(ctrlText 1400)] call daylight_fnc_shopCalculateTotalProfit;
			if (_iProfit > daylight_cfg_iMaxIntValue) then {
				_iProfit = daylight_cfg_iMaxIntValue;
			};

			(uiNamespace getVariable "daylight_dsplActive" displayCtrl 1700) ctrlSetText (format[localize "STR_SHOP_BUTTON_SELL", _iProfit, localize "STR_CURRENCY", [parseNumber(lbData [1500, lbCurSel 1500]), parseNumber(ctrlText 1400)] call daylight_fnc_invGetItemWeight, localize "STR_WEIGHT_UNIT"]);
		} else {
			if ((lbSize 1500) == 0) then {
				(uiNamespace getVariable "daylight_dsplActive" displayCtrl 1700) ctrlSetText (format[localize "STR_SHOP_BUTTON_SELL", 0, localize "STR_CURRENCY", 0, localize "STR_WEIGHT_UNIT"]);
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

			(uiNamespace getVariable "daylight_dsplActive" displayCtrl 1701) ctrlSetText (format[localize "STR_SHOP_BUTTON_BUY", _iCost, localize "STR_CURRENCY", [parseNumber(lbData [1501, lbCurSel 1501]), parseNumber(ctrlText 1401)] call daylight_fnc_invGetItemWeight, localize "STR_WEIGHT_UNIT"]);
		} else {
			if ((lbSize 1501) == 0) then {
				(uiNamespace getVariable "daylight_dsplActive" displayCtrl 1701) ctrlSetText (format[localize "STR_SHOP_BUTTON_BUY", 0, localize "STR_CURRENCY", 0, localize "STR_WEIGHT_UNIT"]);
				ctrlEnable [1701, false];
			} else {
				lbSetCurSel [1501, 0];
			};
		};

		sleep 0.025;
	};

	if (true) exitWith {};
};

/*
	Description:	Buy item
	Args:			arr [int item id, int amount]
	Return:			nothing
*/
daylight_fnc_shopBuyItem = {
	_iID = (_this select 0);
	_iAmount = round(_this select 1);

	_iRealAmount = [_iID, _iAmount] call daylight_fnc_shopCheckAmount;
	_iTotalCost = [_iID, _iAmount] call daylight_fnc_shopCalculateTotalPrice;

	// Get money in inventory
	_iIndex = [daylight_arrInventory, daylight_cfg_iInvMoneyID] call daylight_fnc_findVariableInNestedArray;
	_iAmountInventory = 0;
	if (_iIndex != -1) then {
		_iAmountInventory = (daylight_arrInventory select _iIndex) select 1;
	};

	if (_iTotalCost <= _iAmountInventory) then {
		closeDialog 0;

		[_iID, _iRealAmount] call daylight_fnc_shopRemoveFrom;
		// Add items to player
		[_iID, _iRealAmount] call daylight_fnc_invAddItem;

		// Remove money from inventory
		[daylight_cfg_iInvMoneyID, _iTotalCost] call daylight_fnc_invRemoveItem;

		// Show notification
		[localize "STR_SHOP_MESSAGE_TITLE", format[localize "STR_SHOP_MESSAGE_BUY_SUCCESS", (_iID call daylight_fnc_invIDToStr) select 0, _iRealAmount, (daylight_vehCurrentMerchant getVariable "daylight_arrMerchantInfo") select 0, _iTotalCost, localize "STR_CURRENCY"], true] call daylight_fnc_showHint;
	} else {
		_iMore = _iTotalCost - _iAmountInventory;

		if (_iMore > daylight_cfg_iMaxIntValue) then {
			_iMore = daylight_cfg_iMaxIntValue;
		};

		// Not enough money, show notification
		[localize "STR_SHOP_MESSAGE_TITLE", format[localize "STR_SHOP_MESSAGE_NOMONEY", _iMore, localize "STR_CURRENCY"], true] call daylight_fnc_showHint;
	};
};

/*
	Description:	Sell item
	Args:			arr [int item id, int amount]
	Return:			nothing
*/
daylight_fnc_shopSellItem = {
	_iID = (_this select 0);

	// Check if we can sell this item
	_arrMerchantInfo = daylight_vehCurrentMerchant getVariable "daylight_arrMerchantInfo";
	if (((((_arrMerchantInfo) select 2) find _iID) != -1) || (count(_arrMerchantInfo) == 0)) then {
		closeDialog 0;

		_iAmount = round(_this select 1);

		_iRealAmount = [_iID, _iAmount] call daylight_fnc_invCheckAmount;
		_iTotalProfit = [_iID, _iAmount] call daylight_fnc_shopCalculateTotalProfit;

		// Check if we need to add to stock at all
		if ((daylight_vehCurrentMerchant getVariable "daylight_arrMerchantInfo") select 3) then {
			[_iID, _iRealAmount] call daylight_fnc_shopAddTo;
		};

		// Remove sold item(s) from inventory
		[_iID, _iRealAmount] call daylight_fnc_invRemoveItem;

		// Add money to player inventory
		[daylight_cfg_iInvMoneyID, _iTotalProfit] call daylight_fnc_invAddItem;

		// Show notification
		[localize "STR_SHOP_MESSAGE_TITLE", format[localize "STR_SHOP_MESSAGE_SELL_SUCCESS", (_iID call daylight_fnc_invIDToStr) select 0, _iRealAmount, (daylight_vehCurrentMerchant getVariable "daylight_arrMerchantInfo") select 0, _iTotalProfit, localize "STR_CURRENCY"], true] call daylight_fnc_showHint;
	} else {
		// We can't sell this item here, show notification
		[localize "STR_SHOP_MESSAGE_TITLE", format[localize "STR_SHOP_MESSAGE_SELL_CANTSELL", (_iID call daylight_fnc_invIDToStr) select 0, (daylight_vehCurrentMerchant getVariable "daylight_arrMerchantInfo") select 0], true] call daylight_fnc_showHint;
	};
};

/*
	Description:	Check if we are trying to put/take more than we have FROM SHOP
	Args:			arr [int item id, int amount]
	Return:			int input (or int max)
*/
daylight_fnc_shopCheckAmount = {
	_iItemID = (_this select 0);
	_iAmount = round(_this select 1);

	// Get merchant inventory
	_arrShopInventory = (daylight_vehCurrentMerchant getVariable ["daylight_arrMerchantInfo", []]) select 1;

	// Make sure amount >= 1
	if (_iAmount >= 1) then {
		// daylight_cfg_iMaxIntValue is max amount we can accurately handle
		if (_iAmount <= daylight_cfg_iMaxIntValue) then {
			// Get item position in array for if (if exists)
			_iItemInShopInventoryPos = [_arrShopInventory, _iItemID] call daylight_fnc_findVariableInNestedArray;

			// Check if item is in inventory
			if (_iItemInShopInventoryPos != -1) then {
				// Check if finite
				if (((_arrShopInventory select _iItemInInventoryPos) select 1) != -1) then {
					// Get item array (contains id and amount)
					_arrInventoryItemArray = (_arrShopInventory select _iItemInShopInventoryPos);

					// Check if we're trying to drop more than we have (remove item from array if we have 0 of that item)
					if ((_arrInventoryItemArray select 1) <= _iAmount) then {
						// Drop amount is all we have
						_iAmount = (_arrInventoryItemArray select 1);
					};
				};
			};
		} else {
			_iAmount = daylight_cfg_iMaxIntValue;
		};
	};

	_iAmount
};

/*
	Description:	Removes item from SHOP
	Args:			arr [int item id, int amount]
	Return:			nothing
*/
daylight_fnc_shopRemoveFrom = {
	// Get parameters
	_iItemID = (_this select 0);
	// Round the value so we don't remove decimal amount
	_iAmount = round(_this select 1);
	// Get merchant inventory
	_arrShopInventory = (daylight_vehCurrentMerchant getVariable ["daylight_arrMerchantInfo", []]) select 1;

	// Make sure amount >= 1
	if (_iAmount >= 1) then {
		// Get item position in array for if (if exists)
		_iItemInInventoryPos = [_arrShopInventory, _iItemID] call daylight_fnc_findVariableInNestedArray;

		// Check if item is in inventory
		if (_iItemInInventoryPos != -1) then {
			// Check if finite
			if (((_arrShopInventory select _iItemInInventoryPos) select 1) != -1) then {
				// Get item array (contains id and amount)
				_arrInventoryItemArray = (_arrShopInventory select _iItemInInventoryPos);

				// Check if we're trying to remove more than we have (remove item from array if we have 0 of that item)
				if ((_arrInventoryItemArray select 1) <= _iAmount) then {
					// Make value -1 and remove it (we need to make the value something else than an array, -1 will do fine)
					_arrShopInventory set [_iItemInInventoryPos, -1];

					// Remove -1
					_arrShopInventory = _arrShopInventory - [-1];
				} else {
					// Calculate new amount
					_iNewAmount = ((_arrInventoryItemArray select 1) - _iAmount);

					// Modify array to new amount
					_arrShopInventory set [_iItemInInventoryPos, [_iItemID, _iNewAmount]];
				};
			};

			// Update trunk
			daylight_vehCurrentMerchant setVariable ["daylight_arrMerchantInfo", [(daylight_vehCurrentMerchant getVariable ["daylight_arrMerchantInfo", ""]) select 0, _arrShopInventory, (daylight_vehCurrentMerchant getVariable ["daylight_arrMerchantInfo", ""]) select 2], true];
		};
	};
};

/*
	Description:	Add item in SHOP
	Args:			arr [int item id, int amount]
	Return:			nothing
*/
daylight_fnc_shopAddTo = {
	// Get parameters
	_iItemID = (_this select 0);
	// Round the value so we don't remove decimal amount
	_iAmount = round(_this select 1);
	// Get vehicle trunk
	_arrShopInventory = (daylight_vehCurrentMerchant getVariable ["daylight_arrMerchantInfo", []]) select 1;

	// Make sure amount >= 1
	if (_iAmount >= 1) then {
		// Get item position in array for if (if exists)
		_iItemInInventoryPos = [_arrShopInventory, _iItemID] call daylight_fnc_findVariableInNestedArray;

		// Check if item is in inventory, don't add it again but add to the amount
		if (_iItemInInventoryPos != -1) then {
			// Check if finite
			if (((_arrShopInventory select _iItemInInventoryPos) select 1) != -1) then {
				// Get item array (contains id and amount)
				_arrInventoryItemArray = (_arrShopInventory select _iItemInInventoryPos);

				// Calculate new amount
				_iNewAmount = ((_arrInventoryItemArray select 1) + _iAmount);

				// Modify array to new amount
				_arrShopInventory set [_iItemInInventoryPos, [_iItemID, _iNewAmount]];
			};
		} else {
			// Add item to inventory
			_arrShopInventory set [(count _arrShopInventory), [_iItemID, _iAmount]];
		};
	};

	// Update trunk
	daylight_vehCurrentMerchant setVariable ["daylight_arrMerchantInfo", [(daylight_vehCurrentMerchant getVariable ["daylight_arrMerchantInfo", ""]) select 0, _arrShopInventory, (daylight_vehCurrentMerchant getVariable ["daylight_arrMerchantInfo", ""]) select 2], true];
};

/*
	Description:	Calculate total price
	Args:			arr [i id, i amount]
	Return:			i total price
*/
daylight_fnc_shopCalculateTotalPrice = {
	_iOutput = 0;

	// Get values from stringtable.csv and set them as the return value
	_iPricePerItem = parseNumber (localize (format["STR_ITEM_%1_PRICE", (_this select 0)]));

	// Calculate output
	_iOutput = (_iPricePerItem * (_this select 1));

	_iOutput
};

/*
	Description:	Calculate total profit
	Args:			arr [i id, i amount]
	Return:			i total price
*/
daylight_fnc_shopCalculateTotalProfit = {
	_iOutput = 0;

	// Get values from stringtable.csv and set them as the return value
	_iProfitPerItem = parseNumber (localize (format["STR_ITEM_%1_PROFIT", (_this select 0)]));

	// Calculate output
	_iOutput = (_iProfitPerItem * (_this select 1));

	_iOutput
};

// Spawn shop merchants
if (isServer) then {
	[] call daylight_fnc_shopSpawnMerchants;
};