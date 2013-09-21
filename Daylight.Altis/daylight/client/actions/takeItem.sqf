/*
	Description: 	Take item action used by objects created by daylight_fnc_dropItem
	Author:			qbt
*/

// Parameters
_objItem = (_this select 0);
_arrPos = getPos _objItem;

_iItemID = ((_this select 3) select 0);
_iItemAmount = ((_this select 3) select 1);

if ([([_iItemID, _iItemAmount] call daylight_fnc_invGetItemWeight)] call daylight_fnc_invCheckWeight) then {
	deleteVehicle (_this select 0);

	// Delete dropped object from game world
	[[_arrPos], {_this call daylight_fnc_dropItemDeleteObject}] call daylight_fnc_execClient;
	// Add to carried weight
	[([_iItemID, _iItemAmount] call daylight_fnc_invGetItemWeight)] call daylight_fnc_invModifyWeight;
	// Add items to takers inv
	[_iItemID, _iItemAmount] call daylight_fnc_invAddItem;
} else {
	["<t size=""2"" color=""#ffffff"">You can't carry that much, max weight reached!</t>"] call daylight_fnc_showActionMsg;
};

if (true) exitWith {};