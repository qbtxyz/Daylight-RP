/*
	Description:	Init for Daylight
	Author:			qbt
*/

// Protection against Steam Workshop.
if (isSteamMission) exitWith {};

/* Config */
// List of scripts that we need to run. (both, client, server)
_arrScriptsShared		= [
];

_arrScriptsClient	= [
	"daylight\client\clientLoop.sqf",
	"daylight\client\hudDraw.sqf",
	"daylight\client\disableSimulationOfNearObjects.sqf",
	"daylight\client\revealSurroundingsToPlayer.sqf",
	"daylight\client\handleRadioChannels.sqf",
	"daylight\client\forceClothing.sqf"
];

_arrScriptsServer	= [
];

// List of functions that we need to initialize. (both, client, server)
_arrFunctionsShared	= [
	"daylight\shared\fnc\daylight_fnc_misc.sqf",
	"daylight\shared\fnc\daylight_fnc_network.sqf",
	"daylight\shared\fnc\daylight_fnc_handleVar.sqf",
	"daylight\shared\fnc\daylight_fnc_characterCreation.sqf",
	"daylight\shared\fnc\daylight_fnc_handleKilled.sqf",
	"daylight\shared\fnc\daylight_fnc_shop.sqf",
	"daylight\shared\fnc\daylight_fnc_jail.sqf",
	"daylight\shared\fnc\daylight_fnc_impound.sqf",
	"daylight\shared\fnc\daylight_fnc_licenses.sqf"
];

_arrFunctionsClient	= [
	"daylight\client\fnc\daylight_fnc_misc.sqf",
	"daylight\client\fnc\daylight_fnc_str.sqf",
	"daylight\client\fnc\daylight_fnc_handleInput.sqf",
	"daylight\client\fnc\daylight_fnc_inv.sqf",
	"daylight\client\fnc\daylight_fnc_trunk.sqf",
	"daylight\client\fnc\daylight_fnc_bank.sqf",
	"daylight\client\fnc\daylight_fnc_interaction.sqf",
	"daylight\client\fnc\daylight_fnc_locking.sqf",
	"daylight\client\fnc\daylight_fnc_shout.sqf",
	"daylight\client\fnc\daylight_fnc_mobilePhone.sqf",
	"daylight\client\fnc\daylight_fnc_stats.sqf"
];

_arrFunctionsServer	= [
];

/* Main script */
// Initialize config init and disable some stuff in briefing
_hConfigInit = execVM "daylight\cfg\init.sqf";
waitUntil {scriptDone _hConfigInit};

// Initialize variables with their default values
call compile preprocessFile "daylight\shared\defVariables.sqf";

// Initialize functions
{
	call compile preprocessFile _x;
} forEach _arrFunctionsShared;

if (!isDedicated) then {
	{
		call compile preprocessFile _x;
	} forEach _arrFunctionsClient;
};

if (isServer) then {
	{
		call compile preprocessFile _x;
	} forEach _arrFunctionsServer;
};

enableRadio false;
enableSaving [false, false];
enableSentences false;
enableTeamSwitch false;
player disableConversation true;

// Sleep a moment to make sure we don't initialize anything else in briefing.
sleep 0.001;

startLoadingScreen [""];

// Disable sound, music, etc. while loading.
enableEnvironment false;
[0, 0] call daylight_fnc_setMasterVolume;

// Execute scripts for both, client and server
{
	_hSQF = execVM _x;
} forEach _arrScriptsShared;

if (!isDedicated) then {
	{
		_hSQF = execVM _x;
	} forEach _arrScriptsClient;
};

if (isServer) then {
	{
		_hSQF = execVM _x;
	} forEach _arrScriptsServer;
};

// Apply some config from cfgMain
setTerrainGrid daylight_cfg_iTerrainGrid;
setViewDistance daylight_cfg_iViewDistanceTerrain;
setObjectViewDistance daylight_cfg_iViewDistanceObjects;
setShadowDistance daylight_cfg_iViewDistanceShadow;
setDetailMapBlendPars [daylight_cfg_iDetailMapDistance, daylight_cfg_iDetailMapDistance];
setDate daylight_cfg_arrDateStart;

// Create respawn markers to move players in to a safe-area.
createMarkerLocal ["respawn_civilian", daylight_cfg_arrRespawnHoldPos];

// Enable sound, music, etc. after loading. Only enable env for clients.
if (!isDedicated) then {
	enableEnvironment true;
};

endLoadingScreen;

if (!isDedicated) then {
	// Attach EH's to player
	player call daylight_fnc_addDefaultEventHandlers;

	// Set custom recoilCoefficient to player
	player setUnitRecoilCoefficient daylight_cfg_iRecoilCoefficient;

	// Start character creation
	[] spawn daylight_fnc_characterCreationInit;

	// Appy color correction for clients
	[] call daylight_fnc_setDefaultColorCorrection;
};

// Add money to player for debugging
[10000, 1000] call daylight_fnc_invAddItemWithWeight;

if (true) exitWith {};