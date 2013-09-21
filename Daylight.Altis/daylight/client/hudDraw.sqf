/*
	Description:	HUD for Daylight
	Author:			qbt
*/

disableSerialization;

// Apply vignette
250 cutRsc ["OverlayVignette", "PLAIN", 0.001];

// Initialize nametags
500 cutRsc ["InfoTags", "PLAIN", 0.001];

// Initialize HUD
1000 cutRsc ["DaylightHUD", "PLAIN", 0.001];

// Get variables set in RscTitles.hpp
_dDisplay = ((uiNamespace getVariable "daylight_arrRscInfoTag") select 0);
_cInfoTagsTextControl = _dDisplay displayCtrl ((uiNamespace getVariable "daylight_arrRscInfoTag") select 1);

_dDisplay = ((uiNamespace getVariable "daylight_arrRscDaylightHUD") select 0);
_cHUDControlLT = _dDisplay displayCtrl ((uiNamespace getVariable "daylight_arrRscDaylightHUD") select 1);
_cHUDControlRT = _dDisplay displayCtrl ((uiNamespace getVariable "daylight_arrRscDaylightHUD") select 2);
_cHUDControlLB = _dDisplay displayCtrl ((uiNamespace getVariable "daylight_arrRscDaylightHUD") select 3);
_cHUDControlRB = _dDisplay displayCtrl ((uiNamespace getVariable "daylight_arrRscDaylightHUD") select 4);

// Wait until character saved
waitUntil {daylight_bCharacterCreated && !(isNil "daylight_arrMerchants")};

// HUD main loop
while {true} do {
	_strTag = "";

	// InfoTags
	if (!visibleMap && (cursorTarget != player) && !(isNull cursorTarget) && ((cursorTarget distance player) < 10) && (abs(((getPosATL cursorTarget) select 2) - ((getPosATL player) select 2)) <= 1.5) && (alive cursorTarget)) then {
		if (isPlayer cursorTarget) then {
			if ((side cursorTarget) == civilian) then {
				// Check if local player's UID is in the list
				if ([cursorTarget, player] call daylight_fnc_hasIntroducedTo) then {
					_arrCharacterData = [(crew(cursorTarget) select 0), format["arrCharacterData%1", cursorTarget call daylight_fnc_returnSideStringForSavedVariables], ["", ""]] call daylight_fnc_loadVar;
					_strName = format["%1", _arrCharacterData select 0];
					_strDescription = format["%1", _arrCharacterData select 1];
					_strTag = format["<t align=""center"" shadow=""1""><t size=""2.7"" color=""#ffffff"">%1</t><br/><t size=""2"" color=""#dbdbdb"">[%2]</t><br/><br/><t size=""1.8"" color=""#cccccc"">(%3)</t></t>", _strName, _strDescription, name((crew(cursorTarget) select 0))];
				} else {
					_strDescription = format["%1", (([(crew(cursorTarget) select 0), format["arrCharacterData%1", cursorTarget call daylight_fnc_returnSideStringForSavedVariables], ["", ""]] call daylight_fnc_loadVar) select 1)];
					_strTag = format["<t align=""center"" shadow=""1""><t size=""2.7"" color=""#ffffff"">Unknown</t><br/><t size=""2"" color=""#dbdbdb"">[%1]</t><br/><br/><t size=""1.8"" color=""#cccccc"">(%2)</t></t>", _strDescription, name((crew(cursorTarget) select 0))];
				};
			} else {
				_arrCharacterData = [(crew(cursorTarget) select 0), format["arrCharacterData%1", cursorTarget call daylight_fnc_returnSideStringForSavedVariables], ["", ""]] call daylight_fnc_loadVar;
				_strName = format["%1", _arrCharacterData select 0];
				_strDescription = format["%1", _arrCharacterData select 1];
				_strTag = format["<t align=""center"" shadow=""1""><t size=""2.7"" color=""#ffffff"">%1</t><br/><t size=""2"" color=""#dbdbdb"">[%2]</t><br/><br/><t size=""1.8"" color=""#cccccc"">(%3)</t></t>", _strName, _strDescription, name((crew(cursorTarget) select 0))];
			};
		} else {
			// Is cursorTarget merchant
			if ((daylight_arrMerchants find cursorTarget) != -1) then {
				_strTagName = (cursorTarget getVariable "daylight_arrMerchantInfo") select 0;
				_strTag = format["<t align=""center"" shadow=""1""><t size=""2.7"" color=""#ffffff"">%1</t> <t size=""1.5"" color=""#dbdbdb"">(E)</t></t>", _strTagName];
			};

			// Is cursorTarget impound officer
			if ((daylight_arrImpoundOfficers find cursorTarget) != -1) then {
				_strTagName = "Impound Officer"; // TO-DO: Localize
				_strTag = format["<t align=""center"" shadow=""1""><t size=""2.7"" color=""#ffffff"">%1</t> <t size=""1.5"" color=""#dbdbdb"">(E)</t></t>", _strTagName];
			};

			// Is cursorTarget license seller
			if ((daylight_arrLicenseSellers find cursorTarget) != -1) then {
				_strTagName = "License Seller"; // TO-DO: Localize
				_strTag = format["<t align=""center"" shadow=""1""><t size=""2.7"" color=""#ffffff"">%1</t> <t size=""1.5"" color=""#dbdbdb"">(E)</t></t>", _strTagName];
			};

			// Is cursorTarget misc interactable unit
			if ((daylight_arrMiscInteractableUnits find cursorTarget) != -1) then {
				_strTagName = (daylight_cfg_arrMiscInteractableUnits select (daylight_arrMiscInteractableUnits find cursorTarget)) select 3;
				_strTag = format["<t align=""center"" shadow=""1""><t size=""2.7"" color=""#ffffff"">%1</t></t>", _strTagName];
			};
		};
	};

	// Apply text to InfoTags text control
	_cInfoTagsTextControl ctrlSetStructuredText (parseText _strTag);

	// HUD
	if (!visibleMap) then {
		_cHUDControlRT ctrlSetStructuredText (parseText format["<t align=""right"" size=""1.75"" color=""#ffffff"" shadow=""1"">%1</t>", currentWeaponMode gunner(vehicle player)]);
		_cHUDControlLT ctrlSetStructuredText (parseText format["<t align=""left"" size=""1.75"" color=""#ffffff"" shadow=""1"">%1</t>", [player, format["arrCharacterData%1", player call daylight_fnc_returnSideStringForSavedVariables], ["", ""]] call daylight_fnc_loadVar select 0]);
	} else {
		_cHUDControlRT ctrlSetStructuredText (parseText "");
		_cHUDControlLT ctrlSetStructuredText (parseText "");
	};

	sleep 0.1;
};