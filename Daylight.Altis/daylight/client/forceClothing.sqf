/*
	Description:	Force player clothing
	Author:			qbt
*/

removeHeadgear player;
removeGoggles player;
removeUniform player;
removeVest player;

waitUntil {daylight_bCharacterClothed || ((side player) == blufor)};

_arrClothing = [];
if ((side player) == civilian) then {
	_arrClothing = [player, format["arrClothing%1", player call daylight_fnc_returnSideStringForSavedVariables], []] call daylight_fnc_loadVar;
} else {
	_arrClothing = daylight_cfg_arrClothingBlufor;
};

while {true} do {
	// Remove near WeaponHolders
	_bRemoveNearWeaponHolders = false;

	// Check if player has same headgear
	if ((headgear player) != (_arrClothing select 0)) then {
		_bRemoveNearWeaponHolders = true;

		if ((_arrClothing select 0) == "") then {
			removeHeadgear player;
		} else {
			player addHeadgear (_arrClothing select 0);
		};
	};

	// Check if player has same goggles
	if ((goggles player) != (_arrClothing select 1)) then {
		_bRemoveNearWeaponHolders = true;

		if ((_arrClothing select 1) == "") then {
			removeGoggles player;
		} else {
			player addGoggles (_arrClothing select 1);
		};
	};

	// Check if player has same uniform
	if ((uniform player) != (_arrClothing select 2)) then {
		_bRemoveNearWeaponHolders = true;

		player addUniform (_arrClothing select 2);
	};

	// Check if player has same vest (blufor)
	if ((side player) == blufor) then {
		if ((vest player) != (_arrClothing select 3)) then {
			_bRemoveNearWeaponHolders = true;

			if ((_arrClothing select 3) == "") then {
				removeVest player;
			} else {
				player addVest (_arrClothing select 3);
			};
		};
	};

	if (_bRemoveNearWeaponHolders) then {
		_arrNearWeaponHolders = nearestObjects [player, ["WeaponHolder", "WeaponHolderSimulated"], 5];

		deleteVehicle(_arrNearWeaponHolders select 0);

		_arrNearItemsWithCargo = nearestObjects [player, ["AllVehicles", "ReammoBox"], 5];

		{
			if (!(isPlayer vehicle(_x)) && !(_x isKindOf "Man")) then {
				[vehicle(_x), _arrClothing select 0] call daylight_fnc_removeItemsFromCargo;
				[vehicle(_x), _arrClothing select 1] call daylight_fnc_removeItemsFromCargo;
				[vehicle(_x), _arrClothing select 2] call daylight_fnc_removeItemsFromCargo;
			};
		} forEach _arrNearItemsWithCargo;
	};

	sleep 0.1;
};