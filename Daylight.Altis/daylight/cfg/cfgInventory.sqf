/*
	Description:	Inventory config
	Author:			qbt
*/

// General settings
daylight_cfg_iInvMaxCarryWeight				= 60; // 60kg
daylight_cfg_iInvMaxGiveDistance			= 5; // meters
daylight_cfg_iInvMaxInputItemAmountDigits	= 5;

daylight_cfg_iInvMoneyID					= 10000; // ID of money

// Illegal item config
daylight_cfg_arrInvIllegalIDRange			= [70000, 80000];

// Unusable & undroppable items config
daylight_cfg_arrUnusableItems				= [10000];
daylight_cfg_arrUndroppableItems			= [];

// Normal items
daylight_cfg_strDefaultItemClassName		= "Land_Suitcase_F";

// Special items
daylight_cfg_arrSpecialItems				= [
	[daylight_cfg_iInvMoneyID, "Land_Suitcase_F"]
];