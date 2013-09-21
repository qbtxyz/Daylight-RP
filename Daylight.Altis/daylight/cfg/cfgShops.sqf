/*
	Description:	Shops config file
	Author:			qbt
*/

/*
	Notes:

	-1 stock = infinite stock
*/

_cfg_arrTestMerchantDefault = [
	// [i item id, i stock]
	[10001, -1]
];

daylight_cfg_arrMerchants	= [
	// [arr [str classname, str face, str headgear, str goggles, str uniform, str vest], str name, arr default stock, arr accepted ids, arr pos, i dir, b add item to stock when sold]

	// Shop under bridge
	[
		["c_man_1", "", "h_cap_blk", "g_squares", "u_rangemaster", ""],
		"Test Shop",
		_cfg_arrTestMerchantDefault,
		[70001],
		[3753, 12999, 0.15],
		270,
		true
	]
];