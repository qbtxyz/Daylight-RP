/*
	Description:	Main config file for Daylight
	Author:			qbt
*/

// Performance
daylight_cfg_iViewDistanceTerrain				= 3000;						// Max VD, user can lower setting.
daylight_cfg_iViewDistanceObjects				= 750;
daylight_cfg_iViewDistanceShadow				= 100;
daylight_cfg_iTerrainGrid						= 50;
daylight_cfg_iDetailMapDistance					= 300;

// Gameplay
daylight_cfg_arrDateStart						= [2013, 6, 1, 15, 0];

daylight_cfg_iRecoilCoefficient					= 3;						// Custom recoilCoefficient (by default value 3 used to make firefigts last longer)

// Respawn
daylight_cfg_arrRespawnPos						= [3758, 12997, 0];		// Actual respawn pos.
daylight_cfg_iRespawnDir						= 270;						// Dir player will be facing when respawned.
daylight_cfg_arrRespawnHoldPos					= [14505, 5913, 0];		// Safe zone position where the player will spawn until moved to actual respawn location.
daylight_cfg_iRespawnTimeMin					= 10;
daylight_cfg_arrRespawnTimeAddedPerKillPerSide	= [10, 20];					// Amount of time added per kill per side in seconds. [civ, blufor]

// Misc
daylight_cfg_iMaxIntValue						= 999999;

// Items that always have simulation enabled
daylight_cfg_arrSimluationEnabled				= [];

// Interaction Menu max player distance from interacted
daylight_cfg_iMaxDistanceFromInteractedUnit		= 2.5;

// Main color correction params
daylight_cfg_arrDefaultColorCorrection			= [1, 1, -0.125, [0, 0, 0, 0], [0.5, 0.5, 0.5, 1.1], [0, 0, 0, 0]];
daylight_cfg_arrDefaultColorInversion			= [-0.02, -0.02, 0.02];

// Overview camera parameters
daylight_cfg_arrCamOverviewPos					= [3742, 12970, 25];
daylight_cfg_arrCamOverviewTarget				= [3350, 13258, 0];
daylight_cfg_iCamOverviewFOV					= 0.7;