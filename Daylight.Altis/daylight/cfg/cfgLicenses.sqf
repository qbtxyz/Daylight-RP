/*
	Description:	License config
	Author:			qbt
*/

// Main config
daylight_cfg_arrLicenses = [
	["Drivers License", 100],
	["Boat License", 150]
];

daylight_cfg_arrLicenseSellers = [
	// arr [arr clothing, arr officer position, i officer dir, arr list of licenses sold [[i index from daylight_cfg_arrLicenses, i cost]]

	// Main license seller
	[
		["c_man_1", "", "h_cap_blk", "g_squares", "u_rangemaster", ""],
		[3754, 12982, 0.15],
		0,
		[
			[0, 100],
			[1, 50]
		]
	]
];