/*
	Description:	Init for Daylight config files
	Author:			qbt
*/

_arrConfigs	= [
	"cfgMain.sqf",
	"cfgStrings.sqf",
	"cfgInventory.sqf",
	"cfgEconomy.sqf",
	"cfgChat.sqf",
	"cfgClothing.sqf",
	"cfgShops.sqf",
	"cfgInteraction.sqf",
	"cfgJail.sqf",
	"cfgImpound.sqf",
	"cfgLicenses.sqf",
	"cfgMisc.sqf",
	"cfgShout.sqf"
];

{
	call compileFinal preprocessFile (format["daylight\cfg\%1", _x])
} forEach _arrConfigs;

if (true) exitWith {};