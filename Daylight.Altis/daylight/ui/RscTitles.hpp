class MsgText {
	idc						= -1;
	type					= CT_STRUCTURED_TEXT;
	style					= ST_LEFT;

	x						= safeZoneX;
	y						= safeZoneY + (safeZoneH * 0.15);
	w						= safeZoneW;
	h						= 0.6;

	size					= 0.02;
	text					= "";
};

class MsgBg {
	idc						= -1;
	type					= CT_STATIC;
	style					= ST_LEFT;

	x						= safeZoneXAbs;
	y						= safeZoneY;
	w						= safeZoneWAbs;
	h						= safeZoneH;

	colorBackground[]		= {0, 0, 0, 1};
	colorText[]				= {0, 0, 0, 0};

	size					= 0.02;
	sizeEx					= 0.02;
	font					= "EtelkaNarrowMediumPro";
	text					= "";
};

class OverlayImg {
	idc						= -1;
	type					= CT_STATIC;
	style					= ST_PICTURE;

	x						= safeZoneXAbs;
	y						= safeZoneY;
	w						= safeZoneWAbs;
	h						= safeZoneH;

	colorText[] 			= {0, 0, 0, 1};
	colorBackground[] 		= {0, 0, 0, 1};

	sizeEx					= 0.02;
	font					= "EtelkaNarrowMediumPro";
	text					= "";
};

class RscTitles {
	class DaylightIntro {
		idd							= 000000001;
		movingEnable				= 0;
		duration					= 2;
		controls[]					= {"DaylightIntroText"};
		onLoad						= "uiNamespace setVariable [""daylight_arrRscDaylightIntroText"", [(_this select 0), 000000002]]";

		class DaylightIntroText : MsgText {
			idc						= 000000002;
		};
	};

	class InfoTags {
		idd							= 000000003;
		movingEnable				= 0;
		duration					= 999999999;
		controlsBackground[]		= {"infoTag"};
		onLoad						= "uiNamespace setVariable [""daylight_arrRscInfoTag"", [(_this select 0), 000000004]]";

		class infoTag : MsgText {
			idc						= 000000004;
		};
	};

	class GeneralMsg {
		idd							= 000000005;
		movingEnable				= 0;
		duration					= 999999999;
		controls[]					= {"GeneralMsgText"};
		controlsBackground[]		= {"GeneralMsgBg"};
		onLoad						= "uiNamespace setVariable [""daylight_arrRscGeneralMsg"", [(_this select 0), 000000006]]";

		class GeneralMsgText : MsgText {
			idc						= 000000006;
		};
		class GeneralMsgBg : MsgBg {};
	};

	class OverlayGasmask {
		idd							= -1;
		movingEnable				= 0;
		duration					= 999999999;
		controls[]					= {"OverlayGasmaskImg"};

		class OverlayGasmaskImg : OverlayImg {
			text					= "daylight\gfx\overlay\gasmask.paa";
		};
	};

	class ActionMsg {
		idd							= 000000009;
		movingEnable				= 0;
		duration					= 5;
		controls[]					= {"ActionMsgText"};
		onLoad						= "uiNamespace setVariable [""daylight_arrRscActionMsg"", [(_this select 0), 000000010]]";

		class ActionMsgText : MsgText {
			idc						= 000000010;
			x						= safeZoneX;
			y						= safeZoneY + (safeZoneH * 0.75);
			w						= safeZoneW;
			h						= 0.6;
		};
	};

	class OverlayVignette {
		idd							= -1;
		movingEnable				= 0;
		duration					= 999999999;
		controls[]					= {"OverlayVignetteImg"};

		class OverlayVignetteImg : OverlayImg {
			colorText[] 			= {0, 0, 0, 0.9};

			text					= "daylight\gfx\overlay\vignette.paa";
		};
	};

	class DaylightHUD {
		idd							= 000000013;
		movingEnable				= 0;
		duration					= 999999999;
		controls[]					= {"DaylightHUD_LT", "DaylightHUD_RT", "DaylightHUD_LB", "DaylightHUD_RB"};
		onLoad						= "uiNamespace setVariable [""daylight_arrRscDaylightHUD"", [(_this select 0), 000000014, 000000015, 000000016, 000000017]]";

		class DaylightHUD_LT : MsgText {
			idc						= 000000014;
			x						= safeZoneX + (safeZoneW * 0.005);
			y						= safeZoneY + (safeZoneH * 0.0075);
			w						= (safeZoneW * 0.25);
			h						= 0.25;
		};

		class DaylightHUD_RT : MsgText {
			idc						= 000000015;
			x						= safeZoneX + (safeZoneW * 0.86);
			y						= safeZoneY + (safeZoneH * 0.0075);
			w						= (safeZoneW * 0.135);
			h						= 0.25;
		};

		class DaylightHUD_LB : MsgText {
			idc						= 000000016;
			x						= safeZoneX + (safeZoneW * 0.0075);
			y						= safeZoneY + (safeZoneH * 0.95);
			w						= (safeZoneW * 0.135);
			h						= 0.1;
		};

		class DaylightHUD_RB : MsgText {
			idc						= 000000017;
			x						= safeZoneX + (safeZoneW * 0.86);
			y						= safeZoneY + (safeZoneH * 0.95);
			w						= (safeZoneW * 0.135);
			h						= 0.1;
		};
	};
};