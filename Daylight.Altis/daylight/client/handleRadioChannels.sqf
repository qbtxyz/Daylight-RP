/*
	Description:	Handles new radio channels for Daylight
	Author:			qbt
*/

// Wait until character created
waitUntil {daylight_bCharacterCreated};

// Add radio channels
daylight_iRadioChannelGlobalOOC = radioChannelCreate daylight_cfg_arrChannelGlobalOOC;

// Update radio channels
while {true} do {
	// Clear all units from radio channels
	daylight_iRadioChannelGlobalOOC radioChannelRemove playableUnits;

	// Update global OOC with all playable units
	daylight_iRadioChannelGlobalOOC radioChannelAdd playableUnits;

	sleep 5;
};