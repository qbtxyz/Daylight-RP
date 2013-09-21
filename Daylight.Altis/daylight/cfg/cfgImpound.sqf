/*
	Description:	Impound config
	Author:			qbt
*/

// Main config
daylight_cfg_arrImpoundStoreLocation		= [7092, 5965, 0]; // Fix this for Altis
daylight_cfg_arrImpoundReturnLocation		= [3045, 6074, 0]; // Fix this for Altis
daylight_cfg_iImpoundReturnDir				= 275;

daylight_cfg_iImpoundReturnCost				= 1000;

daylight_cfg_arrImpoundAction				= ["Impound vehicle", "daylight\client\actions\impoundVehicle.sqf", nil, 0, false, true, "", "(((crew _target find player) == -1) && ((vehicle player) == player) && ((_this distance _target) < 3.5))"];

daylight_cfg_arrImpoundOfficers				= [
	// arr [arr clothing, arr officer position, i officer dir, arr impound return pos,i impound return dir]

	// Main impound officer
	[
		["c_man_1", "", "h_cap_blk", "g_squares", "u_rangemaster", ""],
		[3760, 12982, 0.15],
		0,
		[3045, 6074, 0],
		275
	]
]