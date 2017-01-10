#define ST_CENTER         0x02
/*
    Author: Daniel Stuart

    File: hud_stats.hpp
*/

class playerHUD {
    idd = -1;
    duration = 10e10;
    movingEnable = 0;
    fadein = 0;
    fadeout = 0;
    name = "playerHUD";
    onLoad = "uiNamespace setVariable ['playerHUD',_this select 0]";
    objects[] = {};
    controls[] = {
        Life_RscBackground_HUD,
        Life_RscProgress_HUDFood,
        Life_RscProgress_HUDHealth,
        Life_RscProgress_HUDWater,
        Life_RscProgress_HUDXP,
        Life_RscText_HUDFood,
        Life_RscText_HUDHealth,
        Life_RscText_HUDWater,
        Life_RscText_HUDXP,
        Life_StatusBar,
        Life_Picture_Watermark
    };

    /* Background */
    class Life_RscBackground_HUD: Life_RscBackground {
        colorBackground[] = {0,0,0,0.35};
        //x = 0.414815 * safezoneW + safezoneX;
        x = 0.39 * safezoneW + safezoneX;
        y = 0.966667 * safezoneH + safezoneY;
        //w = 0.170371 * safezoneW;
        w = 0.22 * safezoneW;
        h = 0.0333333 * safezoneH;
    };

    /* Progress Bars */
    class LIFE_RscProgress_HUDCommon: Life_RscProgress {
        colorFrame[] = {0, 0, 0, 0.8};
        y = 0.972223 * safezoneH + safezoneY;
        w = 0.0462964 * safezoneW;
        h = 0.0222222 * safezoneH;
    };

    class Life_RscProgress_HUDFood: LIFE_RscProgress_HUDCommon {
        idc = 2200;
        colorBar[] = {0,0.50,0,0.65};
        //x = 0.418981 * safezoneW + safezoneX;
        x = 0.3900453 * safezoneW + safezoneX;
    };

    class Life_RscProgress_HUDHealth: LIFE_RscProgress_HUDCommon {
        idc = 2201;
        colorBar[] = {0.85,0.05,0,0.65};
        //x = 0.476852 * safezoneW + safezoneX;
        x = 0.4479163 * safezoneW + safezoneX;
    };

    class Life_RscProgress_HUDWater: LIFE_RscProgress_HUDCommon {
        idc = 2202;
        colorBar[] = {0,0.25,0.65,0.65};
        //x = 0.534723 * safezoneW + safezoneX;
        x = 0.5057873 * safezoneW + safezoneX;
    };
    
    class Life_RscProgress_HUDXP: LIFE_RscProgress_HUDCommon {
        idc = 2203;
        colorBar[] = {0.85,0.85,0,0.65};
        x = 0.5636583 * safezoneW + safezoneX;    
    	
    };

    /* Texts */
    class Life_RscText_HUDCommon: Life_RscText {
        SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        style = ST_CENTER;
        y = 0.970023 * safezoneH + safezoneY;
        w = 0.0462964 * safezoneW;
        h = 0.0222222 * safezoneH;
    };

    class Life_RscText_HUDFood: Life_RscText_HUDCommon {
        idc = 1200;
        text = "$STR_HUD_Food";
        //x = 0.418981 * safezoneW + safezoneX;
        x = 0.3900453 * safezoneW + safezoneX;
    };

    class Life_RscText_HUDHealth: Life_RscText_HUDCommon {
        idc = 1201;
        text = "$STR_HUD_Health";
        //x = 0.476852 * safezoneW + safezoneX;
        x = 0.4479163 * safezoneW + safezoneX;
    };

    class Life_RscText_HUDWater: Life_RscText_HUDCommon {
        idc = 1202;
        text = "$STR_HUD_Water";
        //x = 0.534723 * safezoneW + safezoneX;
        x = 0.5057873 * safezoneW + safezoneX;
    };
    
    class Life_RscText_HUDXP: Life_RscText_HUDCommon {
        idc = 1203;
        text = "$STR_HUD_XP";
        x = 0.5636583 * safezoneW + safezoneX; 
    };
    
    class Life_StatusBar {
        idc = 55554;
	x = safezoneX;
	y = safezoneY + safezoneH - 0.053;
	w = safezoneW;
	h = 0.06;
	shadow = false;
	colorBackground[] = { 0.074, 0.082, 0.105, 0 };
	font = "PuristaMedium";
	size = 0.032;
	type = 13;
	style = 2;
	colorText[] = {1, 1, 1, 1};
	text="Loading Tanoa Life Status Bar...";
	class Attributes {
	    align="right";
	    color = "#ffffff";
	    font = "PuristaMedium";
	};
    };
	
     class Life_Picture_Watermark: Life_RscPicture {
                idc = 9999;
                text = "textures\StrayaIcon.paa";
                x = 0.90 * safezoneW + safezoneX;
                y = 0.85 * safezoneH + safezoneY;
                w = 0.10 * safezoneW;
                h = 0.105 * safezoneH;
    };
};
