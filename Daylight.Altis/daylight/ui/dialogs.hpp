/*
	Description:	Dialogs for Daylight
	Author:			qbt
*/

class CharacterCreationCivilian {
	idd = 000000009;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	onKeyDown = "_this call daylight_fnc_handleKeyDownDisableDialogExitByKeyboard";

	class controlsBackground {};

	class objects {};

	class controls {
		class RscText_1000: RscText {
			idc = 1000;
			text = "$STR_DIALOG_CREATE_YOUR_CHARACTER";
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 20 * GUI_GRID_H;
		};

		class RscText_1001: RscText {
			idc = 1001;
			text = "$STR_DIALOG_MOTD";
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class IGUIBack_2201: IGUIBack {
			idc = 2201;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 8 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscStructuredText_1100: RscStructuredText {
			idc = 1100;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 7 * GUI_GRID_H;

			size = 0.75 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;

			text = "$STR_MOTD";
		};

		class RscText_1002: RscText {
			idc = 1002;
			text = "$STR_DIALOG_BASIC_INFORMATION";
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 14 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class IGUIBack_2202: IGUIBack {
			idc = 2202;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 6 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscText_1004: RscText {
			idc = 1004;
			text = "$STR_DIALOG_LAST_NAME";
			x = 20.25 * GUI_GRID_W + GUI_GRID_X;
			y = 15.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscEdit_1400: RscEdit {
			idc = 1400;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iNameFirstMaxLen] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iNameFirstMaxLen] call daylight_fnc_limitRscEditInputLen";
		};

		class RscEdit_1401: RscEdit {
			idc = 1401;
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iNameLastMaxLen] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iNameLastMaxLen] call daylight_fnc_limitRscEditInputLen";
		};

		class RscText_1003: RscText {
			idc = 1003;
			text = "$STR_DIALOG_FIRST_NAME";
			x = 13.25 * GUI_GRID_W + GUI_GRID_X;
			y = 15.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscText_1005: RscText {
			idc = 1005;
			text = "$STR_DIALOG_CHARACTER_DESCRIPTION";
			x = 13.25 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscEdit_1402: RscEdit {
			idc = 1402;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 19 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iDescriptionMaxLen] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iDescriptionMaxLen] call daylight_fnc_limitRscEditInputLen";
		};

		class RscShortcutButton_2600: RscShortcutButton {
			x = 22.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21.35 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.25 * GUI_GRID_H;

			colorBackground[] = {0, 0.49, 1, 1};

			text = "$STR_DIALOG_OK";
			action = "if ((((ctrlText 1400) call daylight_fnc_strLen) != 0) && (((ctrlText 1401) call daylight_fnc_strLen) != 0) && (((ctrlText 1402) call daylight_fnc_strLen) != 0)) then {closeDialog 0; [ctrlText 1400, ctrlText 1401, ctrlText 1402] call daylight_fnc_characterCreationSaveCharacter}";
		};

		class RscShortcutButton_2700: RscShortcutButton {
			x = 17.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21.35 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.25 * GUI_GRID_H;

			colorBackground[] = {0, 0.49, 1, 1};

			text = "$STR_DIALOG_CANCEL";
			action = "endMission ""END1"""; // Terminate mission TO-DO: localize endMission str
		};
	};
};

class CharacterCreationBlufor {
	idd = 000000010;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	onKeyDown = "_this call daylight_fnc_handleKeyDownDisableDialogExitByKeyboard";

	class controlsBackground {};

	class objects {};

	class controls {
		class RscText_1000: RscText {
			idc = 1000;
			text = "$STR_DIALOG_CREATE_YOUR_CHARACTER";
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 20 * GUI_GRID_H;
		};

		class RscText_1001: RscText {
			idc = 1001;
			text = "$STR_DIALOG_MOTD";
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class IGUIBack_2201: IGUIBack {
			idc = 2201;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 8 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscStructuredText_1100: RscStructuredText {
			idc = 1100;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 7 * GUI_GRID_H;

			size = 0.75 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;

			text = "$STR_MOTD";
		};

		class RscText_1002: RscText {
			idc = 1002;
			text = "$STR_DIALOG_BASIC_INFORMATION";
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 14 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class IGUIBack_2202: IGUIBack {
			idc = 2202;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 6 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscText_1004: RscText {
			idc = 1004;
			text = "$STR_DIALOG_LAST_NAME";
			x = 13.25 * GUI_GRID_W + GUI_GRID_X;
			y = 15.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscEdit_1401: RscEdit {
			idc = 1401;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iNameLastMaxLen] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iNameLastMaxLen] call daylight_fnc_limitRscEditInputLen";
		};

		class RscText_1005: RscText {
			idc = 1005;
			text = "$STR_DIALOG_CHARACTER_DESCRIPTION";
			x = 13.25 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscEdit_1402: RscEdit {
			idc = 1402;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 19 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iDescriptionMaxLen] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iDescriptionMaxLen] call daylight_fnc_limitRscEditInputLen";
		};

		class RscShortcutButton_2600: RscShortcutButton {
			x = 22.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21.35 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.25 * GUI_GRID_H;

			colorBackground[] = {0, 0.49, 1, 1};

			text = "$STR_DIALOG_OK";
			action = "if ((((ctrlText 1401) call daylight_fnc_strLen) != 0) && (((ctrlText 1402) call daylight_fnc_strLen) != 0)) then {closeDialog 0; ["""", ctrlText 1401, ctrlText 1402] call daylight_fnc_characterCreationSaveCharacter}";
		};

		class RscShortcutButton_2700: RscShortcutButton {
			x = 17.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21.35 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.25 * GUI_GRID_H;

			colorBackground[] = {0, 0.49, 1, 1};

			text = "$STR_DIALOG_CANCEL";
			action = "endMission ""END1"""; // Terminate mission TO-DO: localize endMission str
		};
	};
};

class Inventory {
	idd = 000000011;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	onKeyDown = "_this call daylight_fnc_handleKeyDownInventoryExit";

	class controlsBackground {};

	class objects {};

	class controls {
		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 2.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 35 * GUI_GRID_W;
			h = 18 * GUI_GRID_H;
		};

		class RscText_1000: RscText {
			idc = 1000;
			text = "Inventory"; //--- ToDo: Localize;
			x = 2.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 35 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class RscText_1001: RscText {
			idc = 1001;
			text = "Items"; //--- ToDo: Localize;
			x = 3.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class RscText_1002: RscText {
			idc = 1002;
			text = "Players"; //--- ToDo: Localize;
			x = 21.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class RscListbox_1500: RscListbox {
			idc = 1500;
			x = 3.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 11 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;

			onLbSelChanged = "_this call daylight_fnc_invUpdateUI";
		};

		class RscText_1003: RscText {
			idc = 1003;
			text = "Description"; //--- ToDo: Localize;
			x = 3.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class RscText_1004: RscText {
			idc = 1004;
			x = 1.03914;
			y = 0.340067;
			w = 0.1;
			h = 0.1;
		};

		class IGUIBack_2202: IGUIBack {
			idc = 2202;
			x = 3.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscText_1005: RscText {
			idc = 1005;
			text = "No item selected."; //--- ToDo: Localize;
			x = 3.75 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			sizeEx = 0.65 * GUI_GRID_H;
		};

		class RscListbox_1501: RscListbox {
			idc = 1501;
			x = 21.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 15 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;

			onLbSelChanged = "ctrlEnable [1701, true]";
		};

		class RscText_1006: RscText {
			idc = 1006;
			text = "Actions"; //--- ToDo: Localize;
			x = 29.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class IGUIBack_2201: IGUIBack {
			idc = 2201;
			x = 29.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 15 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscEdit_1400: RscEdit {
			idc = 1400;
			text = "1"; //--- ToDo: Localize;
			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			style = ST_CENTER;

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iInvMaxInputItemAmountDigits] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iInvMaxInputItemAmountDigits] call daylight_fnc_limitRscEditInputLen";
		};

		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;
			text = "Use"; //--- ToDo: Localize;
			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;

			colorBackground[] = {0, 0.49, 1, 1};

			action = "if (parseNumber(ctrlText 1400) != 0) then {[parseNumber(lbData [1500, lbCurSel 1500]), parseNumber(ctrlText 1400)] call daylight_fnc_useItem}";
		};

		class RscShortcutButton_1701: RscShortcutButton {
			idc = 1701;
			text = "Give"; //--- ToDo: Localize;
			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;

			colorBackground[] = {0, 0.49, 1, 1};

			action = "if (lbCurSel 1501 != -1) then {[(daylight_arrInventoryNearPlayers select (parseNumber(lbData [1501, lbCurSel 1501]))), parseNumber(lbData [1500, lbCurSel 1500]), parseNumber(ctrlText 1400)] call daylight_fnc_giveItem}";
		};

		class RscShortcutButton_1702: RscShortcutButton {
			idc = 1702;
			text = "Drop"; //--- ToDo: Localize;
			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;

			colorBackground[] = {0, 0.49, 1, 1};

			action = "if (parseNumber(ctrlText 1400) != 0) then {[parseNumber(lbData [1500, lbCurSel 1500]), parseNumber(ctrlText 1400)] call daylight_fnc_dropItem}";
		};

		class RscShortcutButton_1703: RscShortcutButton {
			idc = 1703;
			text = "Keychain"; //--- ToDo: Localize;
			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;

			colorBackground[] = {0, 0.49, 1, 1};
		};
	};
};

class ATM {
	idd = 000000012;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	class controlsBackground {};

	class objects {};

	class controls {
		class RscText_1000: RscText {
			idc = 1000;
			text = "$STR_ATM"; //--- ToDo: Localize;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 23 * GUI_GRID_H;
		};

		class RscText_1002: RscText {
			idc = 1002;
			text = "Account Balance"; //--- ToDo: Localize;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class RscText_1001: RscText {
			idc = 1001;
			text = "Withdraw"; //--- ToDo: Localize;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class IGUIBack_2201: IGUIBack {
			idc = 2201;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 5 * GUI_GRID_H;
			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscText_1003: RscText {
			idc = 1003;
			text = "Deposit"; //--- ToDo: Localize;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class IGUIBack_2203: IGUIBack {
			idc = 2203;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 16 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 7.5 * GUI_GRID_H;
			colorBackground[] = {0, 0, 0, 0.3};
		};

		class IGUIBack_2202: IGUIBack {
			idc = 2202;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscText_1004: RscText {
			idc = 1004;
			text = "In Inventory"; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			style = ST_CENTER;
		};

		class RscText_1005: RscText {
			idc = 1005;
			text = "In Bank"; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			style = ST_CENTER;
		};

		class RscText_1006: RscText {
			idc = 1006;
			text = ""; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5.25 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			style = ST_CENTER;
		};

		class RscText_1007: RscText {
			idc = 1007;
			text = ""; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5.25 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			style = ST_CENTER;
		};

		class RscEdit_1400: RscEdit {
			idc = 1400;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			text = "1";

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iInvMaxInputItemAmountDigits] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iInvMaxInputItemAmountDigits] call daylight_fnc_limitRscEditInputLen";
		};

		class RscText_1008: RscText {
			idc = 1008;
			text = "Amount:"; //--- ToDo: Localize;
			x = 13.75 * GUI_GRID_W + GUI_GRID_X;
			y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;
			text = "Withdraw"; //--- ToDo: Localize;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;

			colorBackground[] = {0, 0.49, 1, 1};

			action = "if (((ctrlText 1400) call daylight_fnc_strLen) != 0) then {(ctrlText 1400) call daylight_fnc_bankWithdraw}";
		};

		class RscText_1009: RscText {
			idc = 1009;
			text = "Recipient:"; //--- ToDo: Localize;
			x = 13.75 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscCombo_2100: RscCombo {
			idc = 2100;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 17.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscText_1010: RscText {
			idc = 1010;
			text = "Amount:"; //--- ToDo: Localize;
			x = 13.75 * GUI_GRID_W + GUI_GRID_X;
			y = 19 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscEdit_1401: RscEdit {
			idc = 1401;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 20 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			text = "1";

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iInvMaxInputItemAmountDigits] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iInvMaxInputItemAmountDigits] call daylight_fnc_limitRscEditInputLen";
		};

		class RscShortcutButton_1701: RscShortcutButton {
			idc = 1701;
			text = "Deposit / Transfer"; //--- ToDo: Localize;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 21.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;

			colorBackground[] = {0, 0.49, 1, 1};

			action = "if (((ctrlText 1401) call daylight_fnc_strLen) != 0) then {[parseNumber(lbData [2100, (lbCurSel 2100)]), ctrlText 1401] call daylight_fnc_bankDepositOrTransfer}";
		};
	};
};

class Shop {
	idd = 000000013;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; daylight_bDialogShopOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false; daylight_bDialogShopOpen = false";

	class controlsBackground {};

	class objects {};

	class controls {
		class RscText_1000: RscText {
			idc = 1000;
			text = "Shop"; //--- ToDo: Localize;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 26 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 26 * GUI_GRID_W;
			h = 22.5 * GUI_GRID_H;
		};

		class RscText_1001: RscText {
			idc = 1001;
			text = "Inventory (0/60kg)"; //--- ToDo: Localize;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class RscListbox_1500: RscListbox {
			idc = 1500;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 11 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;

			onLbSelChanged = "_this spawn daylight_fnc_shopUpdateUI";
		};

		class RscText_1002: RscText {
			idc = 1002;
			text = ""; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class RscListbox_1501: RscListbox {
			idc = 1501;
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 11 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;

			onLbSelChanged = "_this spawn daylight_fnc_shopUpdateUI";
		};

		class RscEdit_1400: RscEdit {
			idc = 1400;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			text = "1";

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iInvMaxInputItemAmountDigits] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iInvMaxInputItemAmountDigits] call daylight_fnc_limitRscEditInputLen";
		};

		class RscEdit_1401: RscEdit {
			idc = 1401;
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			text = "1";

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iInvMaxInputItemAmountDigits] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iInvMaxInputItemAmountDigits] call daylight_fnc_limitRscEditInputLen";
		};

		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;
			text = "Sell"; //--- ToDo: Localize;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 22 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};

			size = 0.75 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;

			action = "if ((parseNumber(ctrlText 1400) != 0) && ((lbCurSel 1500) != -1)) then {[parseNumber(lbData [1500, lbCurSel 1500]), parseNumber(ctrlText 1400)] call daylight_fnc_shopSellItem}";
		};

		class RscShortcutButton_1701: RscShortcutButton {
			idc = 1701;
			text = "Buy"; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 22 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};

			size = 0.75 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;

			action = "if ((parseNumber(ctrlText 1401) != 0) && ((lbCurSel 1501) != -1)) then {[parseNumber(lbData [1501, lbCurSel 1501]), parseNumber(ctrlText 1401)] call daylight_fnc_shopBuyItem}";
		};

		class RscText_1003: RscText {
			idc = 1003;
			text = "Description"; //--- ToDo: Localize;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 16 * GUI_GRID_H + GUI_GRID_Y;
			w = 24 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class IGUIBack_2201: IGUIBack {
			idc = 2201;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 24 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscText_1004: RscText {
			idc = 1004;
			text = "No item selected."; //--- ToDo: Localize;
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			sizeEx = 0.65 * GUI_GRID_H;
		};
	};
};

class Trunk {
	idd = 000000014;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; daylight_bDialogTrunkOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false; daylight_bDialogTrunkOpen = false";

	class controlsBackground {};

	class objects {};

	class controls {
		class RscText_1000: RscText {
			idc = 1000;
			text = "Trunk"; //--- ToDo: Localize;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 26 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 26 * GUI_GRID_W;
			h = 22.5 * GUI_GRID_H;
		};

		class RscText_1001: RscText {
			idc = 1001;
			text = "Inventory (0/60kg)"; //--- ToDo: Localize;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class RscListbox_1500: RscListbox {
			idc = 1500;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 11 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;

			onLbSelChanged = "_this spawn daylight_fnc_trunkUpdateUI";
		};

		class RscText_1002: RscText {
			idc = 1002;
			text = "Trunk (0/60kg)"; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class RscListbox_1501: RscListbox {
			idc = 1501;
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 11 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;

			onLbSelChanged = "_this spawn daylight_fnc_trunkUpdateUI";
		};

		class RscEdit_1400: RscEdit {
			idc = 1400;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			text = "1";

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iInvMaxInputItemAmountDigits] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iInvMaxInputItemAmountDigits] call daylight_fnc_limitRscEditInputLen";
		};

		class RscEdit_1401: RscEdit {
			idc = 1401;
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			text = "1";

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iInvMaxInputItemAmountDigits] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iInvMaxInputItemAmountDigits] call daylight_fnc_limitRscEditInputLen";
		};

		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;
			text = ""; //--- ToDo: Localize;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 22 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};

			action = "if ((parseNumber(ctrlText 1400) != 0) && ((lbCurSel 1500) != -1)) then {[parseNumber(lbData [1500, lbCurSel 1500]), parseNumber(ctrlText 1400)] call daylight_fnc_trunkPutIn}";
		};

		class RscShortcutButton_1701: RscShortcutButton {
			idc = 1701;
			text = ""; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 22 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};

			action = "if ((parseNumber(ctrlText 1401) != 0) && ((lbCurSel 1501) != -1)) then {[parseNumber(lbData [1501, lbCurSel 1501]), parseNumber(ctrlText 1401)] call daylight_fnc_trunkTakeFrom}";
		};

		class RscText_1003: RscText {
			idc = 1003;
			text = "Description"; //--- ToDo: Localize;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 16 * GUI_GRID_H + GUI_GRID_Y;
			w = 24 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0, 0.49, 1, 1};
		};

		class IGUIBack_2201: IGUIBack {
			idc = 2201;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 24 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscText_1004: RscText {
			idc = 1004;
			text = "No item selected."; //--- ToDo: Localize;
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			sizeEx = 0.65 * GUI_GRID_H;
		};
	};
};

class CharacterCreationClothingCivilian {
	idd = 000000015;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	onKeyDown = "_this call daylight_fnc_handleKeyDownDisableDialogExitByKeyboard";

	class controlsBackground {};

	class objects {};

	class controls {
		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 21 * GUI_GRID_H;
		};

		class RscText_1000: RscText {
			idc = 1000;
			text = "Character Creation (Clothing)"; //--- ToDo: Localize;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class RscText_1001: RscText {
			idc = 1001;
			text = "Headwear"; //--- ToDo: Localize;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class RscText_1002: RscText {
			idc = 1002;
			text = "Note"; //--- ToDo: Localize;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2201: IGUIBack {
			idc = 2201;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscStructuredText_1100: RscStructuredText {
			idc = 1100;
			text = "$STR_DIALOG_CLOTHING_WARNING"; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13.5 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;

			size = 0.75 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;
		};

		class IGUIBack_2202: IGUIBack {
			idc = 2202;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 6 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscText_1003: RscText {
			idc = 1003;
			text = "Headgear:"; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscCombo_2100: RscCombo {
			idc = 2100;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscText_1004: RscText {
			idc = 1004;
			text = "Glasses:"; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscCombo_2101: RscCombo {
			idc = 2101;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscText_1005: RscText {
			idc = 1005;
			text = "Clothing"; //--- ToDo: Localize;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 17.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2203: IGUIBack {
			idc = 2203;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscText_1006: RscText {
			idc = 1006;
			text = "Outfit:"; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 19 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscCombo_2102: RscCombo {
			idc = 2102;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 20 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;
			text = "OK"; //--- ToDo: Localize;
			x = 22.5 * GUI_GRID_W + GUI_GRID_X;
			y = 22.35 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.25 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "closeDialog 0; [lbData[2100, lbCurSel 2100], lbData[2101, lbCurSel 2101], lbData[2102, lbCurSel 2102]] call daylight_fnc_characterSetClothing";
		};

		class RscShortcutButton_1701: RscShortcutButton {
			idc = 1701;
			text = "Cancel"; //--- ToDo: Localize;
			x = 17.5 * GUI_GRID_W + GUI_GRID_X;
			y = 22.35 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.25 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "endMission ""END1""";
		};
	};
};

class NewCharacterQuestion {
	idd = 000000016;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	onKeyDown = "_this call daylight_fnc_handleKeyDownDisableDialogExitByKeyboard";

	class controlsBackground {};

	class objects {};

	class controls {
		class RscText_1000: RscText {
			idc = 1000;
			text = "Create a new character?"; //--- ToDo: Localize;
			x = 10 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 10 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 11.75 * GUI_GRID_H;
		};

		class IGUIBack_2201: IGUIBack {
			idc = 2201;
			x = 10.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 19 * GUI_GRID_W;
			h = 9 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscStructuredText_1100: RscStructuredText {
			idc = 1100;
			text = "";
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 18.5 * GUI_GRID_W;
			h = 8.5 * GUI_GRID_H;

			size = 0.75 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;
		};

		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;
			text = "$STR_DIALOG_CONTINUE"; //--- ToDo: Localize;
			x = 24 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 5.5 * GUI_GRID_W;
			h = 1.25 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "closeDialog 0";
		};

		class RscShortcutButton_1701: RscShortcutButton {
			idc = 1701;
			text = ""; //--- ToDo: Localize;
			x = 14.5 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 9 * GUI_GRID_W;
			h = 1.25 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "closeDialog 0; createDialog format[""CharacterCreation%1"", player call daylight_fnc_returnSideStringForSavedVariables]";
		};
	};
};

class InteractionMenu {
	idd = 000000017;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; daylight_bDialogInteractionMenuOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false; daylight_bDialogInteractionMenuOpen = false";

	class controlsBackground {};

	class objects {};

	class controls {
		class IGUIBack_2200: IGUIBack {
			idc = 2200;

			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 23 * GUI_GRID_H;
		};

		class RscText_1000: RscText {
			idc = 1000;

			text = "Interact with"; //--- ToDo: Localize;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class RscText_1001: RscText {
			idc = 1001;

			text = "Jail"; //--- ToDo: Localize;
			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2201: IGUIBack {
			idc = 2201;

			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 15.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 8 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.3};
		};

		class RscSlider_1900: RscSlider {
			idc = 1900;

			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 16 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			onSliderPosChanged = "(uiNamespace getVariable ""daylight_dsplActive"" displayCtrl 1704) ctrlSetText format[localize ""STR_INTERACTIONMENU_BUTTON_JAILFOR"", round(sliderPosition 1900)]";
		};

		class RscShortcutButton_1704: RscShortcutButton {
			idc = 1704;

			text = ""; //--- ToDo: Localize;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 17.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "[daylight_vehInteractionCurrentPlayer, round(sliderPosition 1900)] call daylight_fnc_networkJailPlayer";
		};

		class RscShortcutButton_1705: RscShortcutButton {
			idc = 1705;

			text = "Sentences"; //--- ToDo: Localize;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class RscText_1002: RscText {
			idc = 1002;

			text = "Ticket"; //--- ToDo: Localize;
			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2202: IGUIBack {
			idc = 2202;

			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.3};
		};

		class RscShortcutButton_1706: RscShortcutButton {
			idc = 1706;

			text = "Give Ticket"; //--- ToDo: Localize;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "closeDialog 0; [] call daylight_fnc_interactionOpenGiveTicketUI";
		};

		class RscText_1004: RscText {
			idc = 1004;

			text = "General"; //--- ToDo: Localize;
			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2203: IGUIBack {
			idc = 2203;

			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 6.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.3};
		};

		class RscShortcutButton_1703: RscShortcutButton {
			idc = 1703;

			text = "Remove illegal items"; //--- ToDo: Localize;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "daylight_vehInteractionCurrentPlayer call daylight_fnc_networkSeizeIllegalItems";
		};

		class RscShortcutButton_1701: RscShortcutButton {
			idc = 1701;

			text = "Restain/Release"; //--- ToDo: Localize;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "daylight_vehInteractionCurrentPlayer call daylight_fnc_networkRestrainPlayer";
		};

		class RscShortcutButton_1702: RscShortcutButton {
			idc = 1702;

			text = "Body search"; //--- ToDo: Localize;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "daylight_vehInteractionCurrentPlayer call daylight_fnc_networkBodySearchDo";
		};
	};
};

class NotificationWindow {
	idd = 000000018;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	class controlsBackground {};

	class objects {};

	class controls {
		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 24 * GUI_GRID_W;
			h = 20.75 * GUI_GRID_H;
		};

		class RscText_1000: RscText {
			idc = 1000;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 24 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2201: IGUIBack {
			idc = 2201;
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 18 * GUI_GRID_H;
		};

		class RscStructuredText_1100: RscStructuredText {
			idc = 1100;
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 18 * GUI_GRID_H;

			size = 0.75 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;
		};

		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;
			text = "Ok"; //--- ToDo: Localize;
			x = 25.5 * GUI_GRID_W + GUI_GRID_X;
			y = 22 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1.25 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "closeDialog 0";
		};
	};
};

class GiveTicket {
	idd = 000000019;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	class controlsBackground {};

	class objects {};

	class controls {
		class RscText_1000: RscText {
			idc = 1000;
			text = "Give ticket"; //--- ToDo: Localize;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 18.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 18.5 * GUI_GRID_W;
			h = 11.5 * GUI_GRID_H;
		};

		class IGUIBack_2201: IGUIBack {
			idc = 2201;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.5 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};

		class RscStructuredText_1100: RscStructuredText {
			idc = 1100;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.5 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;

			size = 0.75 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;

			text = "Ticket info 123"; // TO-DO: Localize
		};

		class RscText_1001: RscText {
			idc = 1001;
			text = "Reason:"; //--- ToDo: Localize;
			x = 11.25 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscEdit_1400: RscEdit {
			idc = 1400;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscText_1002: RscText {
			idc = 1002;
			text = "Amount:"; //--- ToDo: Localize;
			x = 11.25 * GUI_GRID_W + GUI_GRID_X;
			y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscEdit_1401: RscEdit {
			idc = 1401;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;
			text = "Ticket"; //--- ToDo: Localize;
			x = 24.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "closeDialog 0; [daylight_vehInteractionCurrentPlayer, parseNumber(ctrlText 1401), ctrlText 1400] call daylight_fnc_networkGiveTicket";
		};

		class RscShortcutButton_1701: RscShortcutButton {
			idc = 1701;
			text = "Cancel"; //--- ToDo: Localize;
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "closeDialog 0; daylight_vehInteractionCurrentPlayer call daylight_fnc_interactionOpenUI";
		};
	};
};

class PayTicket {
	idd = 000000020;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	//onKeyDown = "_this call daylight_fnc_handleKeyDownDisableDialogExitByKeyboard";

	class controlsBackground {};

	class objects {};

	class controls {
		class RscText_1000: RscText {
			idc = 1000;
			text = "Pay ticket?"; //--- ToDo: Localize;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 21 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 21 * GUI_GRID_W;
			h = 8.5 * GUI_GRID_H;
		};

		class IGUIBack_2201: IGUIBack {
			idc = 2201;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 5.5 * GUI_GRID_H;
		};

		class RscStructuredText_1100: RscStructuredText {
			idc = 1100;
			text = ""; //--- ToDo: Localize;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 5.5 * GUI_GRID_H;

			size = 0.75 * GUI_GRID_H;
			sizeEx = 0.75 * GUI_GRID_H;
		};

		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;
			text = "Yes"; //--- ToDo: Localize;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "[daylight_vehCurrentTicketer, true] call daylight_fnc_networkReturnTicket";
		};

		class RscShortcutButton_1701: RscShortcutButton {
			idc = 1701;
			text = "No"; //--- ToDo: Localize;
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "[daylight_vehCurrentTicketer, false] call daylight_fnc_networkReturnTicket";
		};
	};
};

class WantUnwantRelease {
	idd = 000000021;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	class controlsBackground {};

	class objects {};

	class controls {
		class RscText_1000: RscText {
			idc = 1000;
			text = "Want/Unwant/Release"; //--- ToDo: Localize;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 18 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 18 * GUI_GRID_W;
			h = 24 * GUI_GRID_H;
		};

		class RscText_1001: RscText {
			idc = 1001;
			text = "Want"; //--- ToDo: Localize;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2201: IGUIBack {
			idc = 2201;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 4.5 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscText_1002: RscText {
			idc = 1002;
			text = "Reason:"; //--- ToDo: Localize;
			x = 12.25 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 15.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscEdit_1400: RscEdit {
			idc = 1400;
			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;
			text = "Set wanted"; //--- ToDo: Localize;
			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "[daylight_vehWantUnwantReleaseCurrentTarget, ctrlText 1400, 0] call daylight_fnc_jailSetWanted; (lbCurSel 2100) call daylight_fnc_jailWantUnwantUpdateOpenUI";
		};

		class RscText_1003: RscText {
			idc = 1003;
			text = "Target"; //--- ToDo: Localize;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2202: IGUIBack {
			idc = 2202;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscCombo_2100: RscCombo {
			idc = 2100;
			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			onLbSelChanged = "_this call daylight_fnc_jailWantUnwantUpdateOpenUI";
		};

		class RscText_1004: RscText {
			idc = 1004;
			text = "Release from jail"; //--- ToDo: Localize;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 19 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2203: IGUIBack {
			idc = 2203;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 20 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 4.5 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscText_1005: RscText {
			idc = 1005;
			text = "Reason:"; //--- ToDo: Localize;
			x = 12.25 * GUI_GRID_W + GUI_GRID_X;
			y = 20 * GUI_GRID_H + GUI_GRID_Y;
			w = 15.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscEdit_1401: RscEdit {
			idc = 1401;
			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscText_1006: RscText {
			idc = 1006;
			text = "Unwant"; //--- ToDo: Localize;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2204: IGUIBack {
			idc = 2204;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 16 * GUI_GRID_W;
			h = 4.5 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};

		class RscText_1007: RscText {
			idc = 1007;
			text = "Reason:"; //--- ToDo: Localize;
			x = 12.25 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscCombo_2101: RscCombo {
			idc = 2101;
			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class RscShortcutButton_1701: RscShortcutButton {
			idc = 1701;
			text = "Set unwanted"; //--- ToDo: Localize;
			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "[daylight_vehWantUnwantReleaseCurrentTarget, parseNumber(lbData [2101, lbCurSel 2101])] call daylight_fnc_jailSetUnwanted; (lbCurSel 2100) call daylight_fnc_jailWantUnwantUpdateOpenUI";
		};

		class RscShortcutButton_1702: RscShortcutButton {
			idc = 1702;
			text = "Release from jail"; //--- ToDo: Localize;
			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};
	};
};

class ImpoundReturn {
	idd = 000000022;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	class controlsBackground {};

	class objects {};

	class controls {
		class RscText_1000: RscText {
			idc = 1000;
			text = "Return impounded vehicle"; //--- ToDo: Localize;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 18 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 18 * GUI_GRID_W;
			h = 17.5 * GUI_GRID_H;
		};

		class RscListbox_1500: RscListbox {
			idc = 1500;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 14.5 * GUI_GRID_H;
		};

		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;
			text = "Return"; //--- ToDo: Localize;
			x = 24 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "parseNumber(lbData [1500, lbCurSel 1500]) call daylight_fnc_impoundReturnVehicleFromUI";
		};

		class RscShortcutButton_1701: RscShortcutButton {
			idc = 1701;
			text = "Cancel"; //--- ToDo: Localize;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "closeDialog 0";
		};
	};
};

class BuyLicense {
	idd = 000000023;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	class controlsBackground {};

	class objects {};

	class controls {
		class RscText_1000: RscText {
			idc = 1000;
			text = "Buy license"; //--- ToDo: Localize;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 18 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 18 * GUI_GRID_W;
			h = 17.5 * GUI_GRID_H;
		};

		class RscListbox_1500: RscListbox {
			idc = 1500;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 14.5 * GUI_GRID_H;
		};

		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;
			text = "Buy"; //--- ToDo: Localize;
			x = 24 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "parseNumber(lbData [1500, lbCurSel 1500]) call daylight_fnc_licensesBuyLicense";
		};

		class RscShortcutButton_1701: RscShortcutButton {
			idc = 1701;
			text = "Cancel"; //--- ToDo: Localize;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "closeDialog 0";
		};
	};
};

class EditShouts {
	idd = 000000024;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	class controlsBackground {};

	class objects {};

	class controls {
		class RscText_1000: RscText {
			idc = 1000;
			text = "Edit shouts"; //--- ToDo: Localize;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 18 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 18 * GUI_GRID_W;
			h = 10 * GUI_GRID_H;
		};

		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;
			text = "Save"; //--- ToDo: Localize;
			x = 23.5 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "[ctrlText 1400, ctrlText 1401, ctrlText 1402, ctrlText 1403, ctrlText 1404] call daylight_fnc_shoutSave";
		};

		class RscShortcutButton_1701: RscShortcutButton {
			idc = 1700;
			text = "Cancel"; //--- ToDo: Localize;
			x = 18 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "closeDialog 0";
		};

		class RscEdit_1400: RscEdit {
			idc = 1400;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;


			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iShoutMaxLen] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iShoutMaxLen] call daylight_fnc_limitRscEditInputLen";
		};

		class RscEdit_1401: RscEdit {
			idc = 1401;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iShoutMaxLen] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iShoutMaxLen] call daylight_fnc_limitRscEditInputLen";
		};

		class RscEdit_1402: RscEdit {
			idc = 1402;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iShoutMaxLen] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iShoutMaxLen] call daylight_fnc_limitRscEditInputLen";
		};

		class RscEdit_1403: RscEdit {
			idc = 1403;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iShoutMaxLen] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iShoutMaxLen] call daylight_fnc_limitRscEditInputLen";
		};

		class RscEdit_1404: RscEdit {
			idc = 1404;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iShoutMaxLen] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iShoutMaxLen] call daylight_fnc_limitRscEditInputLen";
		};
	};
};

class MobilePhone {
	idd = 000000025;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	class controlsBackground {};

	class objects {};

	class controls {
		class RscText_1000: RscText {
			idc = 1000;

			text = "Mobile Phone"; //--- ToDo: Localize;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 21 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};
		
		class IGUIBack_2200: IGUIBack {
			idc = 2200;

			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 21 * GUI_GRID_W;
			h = 21.5 * GUI_GRID_H;
		};
		
		class RscText_1001: RscText {
			idc = 1001;

			text = "Send Message"; //--- ToDo: Localize;
			x = 10.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 19 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};
		
		class IGUIBack_2201: IGUIBack {
			idc = 2201;

			x = 10.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 19 * GUI_GRID_W;
			h = 8 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};
		
		class RscText_1002: RscText {
			idc = 1002;

			text = "Recipient:"; //--- ToDo: Localize;
			x = 10.75 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 18.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		
		class RscCombo_2100: RscCombo {
			idc = 2100;

			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 18 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		
		class RscText_1003: RscText {
			idc = 1003;

			text = "Message:"; //--- ToDo: Localize;
			x = 10.75 * GUI_GRID_W + GUI_GRID_X;
			y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 18.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		
		class RscEdit_1400: RscEdit {
			idc = 1400;

			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 18 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;

			style = ST_MULTI;

			// Limit max lenght of input
			onKeyDown = "[(_this select 0), daylight_cfg_iTextMessageMaxLen] call daylight_fnc_limitRscEditInputLen";
			onKeyUp = "[(_this select 0), daylight_cfg_iTextMessageMaxLen] call daylight_fnc_limitRscEditInputLen";
		};
		
		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;

			text = "Send"; //--- ToDo: Localize;
			x = 24.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "[playableUnits select parseNumber(lbData [2100, lbCurSel 2100]), ctrlText 1400, lbCurSel 2101] call daylight_fnc_mobilePhoneSendMessage";
		};
		
		class RscText_1004: RscText {
			idc = 1004;

			text = "Received Messages"; //--- ToDo: Localize;
			x = 10.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 19 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};
		
		class IGUIBack_2202: IGUIBack {
			idc = 2202;

			x = 10.5 * GUI_GRID_W + GUI_GRID_X;
			y = 14 * GUI_GRID_H + GUI_GRID_Y;
			w = 19 * GUI_GRID_W;
			h = 8.5 * GUI_GRID_H;

			colorBackground[] = {0, 0, 0, 0.3};
		};
		
		class RscListbox_1500: RscListBox {
			idc = 1500;

			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 18 * GUI_GRID_W;
			h = 5.5 * GUI_GRID_H;
		};
		
		class RscShortcutButton_1701: RscShortcutButton {
			idc = 1701;

			text = "Read"; //--- ToDo: Localize;
			x = 24.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "(lbCurSel 1500) call daylight_fnc_mobilePhoneReadMessage";
		};
		
		class RscShortcutButton_1702: RscShortcutButton {
			idc = 1702;

			text = "Cancel"; //--- ToDo: Localize;
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "closeDialog 0";
		};
		
		class RscShortcutButton_1703: RscShortcutButton {
			idc = 1703;

			text = "Cancel"; //--- ToDo: Localize;
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "closeDialog 0";
		};

		class RscCombo_2101: RscCombo {
			idc = 2101;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 10 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
	};
};

class Stats {
	idd = 000000026;
	movingEnable = false;

	onLoad = "daylight_bDialogOpen = true; uiNamespace setVariable [""daylight_dsplActive"", _this select 0]";
	onUnload = "daylight_bDialogOpen = false";

	class controlsBackground {};

	class objects {};

	class controls {
		class RscText_1000: RscText {
			idc = 1000;

			text = "Stats"; //--- ToDo: Localize;
			x = 9 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};
		};

		class IGUIBack_2200: IGUIBack {
			idc = 2200;

			x = 9 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 19 * GUI_GRID_H;
		};

		class RscListbox_1500: RscListBox {
			idc = 1500;

			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 21 * GUI_GRID_W;
			h = 16 * GUI_GRID_H;
		};

		class RscShortcutButton_1700: RscShortcutButton {
			idc = 1700;
			text = "Ok"; //--- ToDo: Localize;
			x = 26 * GUI_GRID_W + GUI_GRID_X;
			y = 20 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0.49,1,1};

			action = "closeDialog 0";
		};
	};
};