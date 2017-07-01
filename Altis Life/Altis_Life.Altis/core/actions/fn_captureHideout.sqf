#include "..\..\script_macros.hpp"
/*
    File: fn_captureHideout.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Blah blah.
*/
private["_group","_hideout","_action","_cpRate","_cP","_progressBar","_title","_titleText","_ui","_flagTexture"];
_hideout = (nearestObjects[getPosATL player,["Land_u_Barracks_V2_F","Land_i_Barracks_V2_F"],25]) select 0;
_group = _hideout getVariable ["gangOwner",grpNull];

if (isNil {group player getVariable "gang_name"}) exitWith {titleText[localize "STR_GNOTF_CreateGang","PLAIN"];};
if (_group == group player) exitWith {titleText[localize "STR_GNOTF_Controlled","PLAIN"]};
if ((_hideout getVariable ["inCapture",FALSE])) exitWith {
	["Error", format [localize "STR_GNOTF_onePersonAtATime"],[1,0,0,1],""] call life_fnc_showNotification;
}; 

if (!isNull _group) then {
    _gangName = _group getVariable ["gang_name",""];
    _action = [
        format[localize "STR_GNOTF_AlreadyControlled",_gangName],
        localize "STR_GNOTF_CurrentCapture",
        localize "STR_Global_Yes",
        localize "STR_Global_No"
    ] call BIS_fnc_guiMessage;

    _cpRate = 0.0045;
} else {
    _cpRate = 0.0075;
};

if (!isNil "_action" && {!_action}) exitWith {titleText[localize "STR_GNOTF_CaptureCancel","PLAIN"];};
life_action_inUse = true;

//Setup the progress bar
disableSerialization;
_title = localize "STR_GNOTF_Capturing";
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

for "_i" from 0 to 1 step 0 do {
    if (animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
        [player,"AinvPknlMstpSnonWnonDnon_medic_1",true] remoteExecCall ["life_fnc_animSync",RCLIENT];
        player switchMove "AinvPknlMstpSnonWnonDnon_medic_1";
        player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
    };
    sleep 0.26;
    if (isNull _ui) then {
        5 cutRsc ["life_progress","PLAIN"];
        _ui = uiNamespace getVariable "life_progress";
        _progressBar = _ui displayCtrl 38201;
        _titleText = _ui displayCtrl 38202;
    };
    _cP = _cP + _cpRate;
    _progressBar progressSetPosition _cP;
    _titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
    _hideout setVariable ["inCapture",true,true];
    if (_cP >= 1 || !alive player) exitWith {_hideout setVariable ["inCapture",false,true];};
    if (life_istazed) exitWith {_hideout setVariable ["inCapture",false,true];}; //Tazed
    if (life_isknocked) exitWith {_hideout setVariable ["inCapture",false,true];}; //Knocked
    if (life_interrupted) exitWith {_hideout setVariable ["inCapture",false,true];};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN"];
player playActionNow "stop";
if (!alive player || life_istazed || life_isknocked) exitWith {life_action_inUse = false;_hideout setVariable ["inCapture",false,true];};
if (player getVariable["restrained",false]) exitWith {life_action_inUse = false;_hideout setVariable ["inCapture",false,true];};
if (life_interrupted) exitWith {life_interrupted = false; titleText[localize "STR_GNOTF_CaptureCancel","PLAIN"]; life_action_inUse = false;_hideout setVariable ["inCapture",false,true];};
life_action_inUse = false;

titleText[localize "STR_GNOTF_Captured","PLAIN"];
_flagTexture = [
        "\A3\Data_F\Flags\Flag_red_CO.paa",
        "\A3\Data_F\Flags\Flag_green_CO.paa",
        "\A3\Data_F\Flags\Flag_blue_CO.paa",
        "\A3\Data_F\Flags\Flag_white_CO.paa",
        "\A3\Data_F\Flags\flag_fd_red_CO.paa",
        "\A3\Data_F\Flags\flag_fd_green_CO.paa",
        "\A3\Data_F\Flags\flag_fd_blue_CO.paa",
        "\A3\Data_F\Flags\flag_fd_orange_CO.paa"
    ] call BIS_fnc_selectRandom;
_this select 0 setFlagTexture _flagTexture;
[[0,1],"STR_GNOTF_CaptureSuccess",true,[name player,(group player) getVariable "gang_name"]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
_hideout setVariable ["inCapture",false,true];
_hideout setVariable ["gangOwner",group player,true];

//Markers
deleteMarker "gangMarkerWT";
deleteMarker "gangMarkerW";
_marker = createMarker ["gangMarkerW", _hideout];
_marker setMarkerColor "ColorRed";
_marker setMarkerType "Empty";
_marker	setMarkerShape "ELLIPSE";
_marker setMarkerSize [75,75];
_markerText = createMarker ["gangMarkerWT", _hideout];
_markerText setMarkerColor "ColorBlack";
_markerText setMarkerText format ["Owned by %1", (group player) getVariable "gang_name" ];
_markerText setMarkerType "mil_warning";