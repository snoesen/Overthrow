private ["_canplace","_base","_isbase","_owner","_typecls","_estate","_pos","_typecls"];

_pos = _this select 0;
_typecls = _this select 1;

_isbase = false;
_canplace = true;

if(_typecls != "Base") then {
	_base = _pos call OT_fnc_nearestBase;
	if !(isNil "_base") then {
		if((_base select 0) distance _pos < 100) then {
			_isbase = true;
		};
	};
	if(!_isbase) then {
		_base = _pos call OT_fnc_nearestObjective;
		if !(isNil "_base") then {
			if(((_base select 1) in (server getvariable "NATOabandoned")) and ((_base select 0) distance _pos) < 100) then {
				_isbase = true;
			};
		};
	};
}else{
	_base = _pos call OT_fnc_nearestBase;
	if !(isNil "_base") then {
		if((_base select 0) distance _pos < 300) then {
			_canplace = false;
		};
	};
	if(_canplace) then {
		_base = _pos call OT_fnc_nearestObjective;
		if((_base select 0) distance _pos < 300) then {
			_canplace = false;
		};
	};
};

if(!_canplace) exitWith {false};

if !(_isbase) then {
	//Building proximity check
	_estate = _pos call OT_fnc_nearestRealEstate;
	if(typename _estate == "ARRAY") then {
		_b = _estate select 0;
		if(_b getVariable ["leased",false]) exitWith {_canplace = false};
		if(typeof _b == OT_item_Tent) exitWith {_canplace = false};
		if(_b call OT_fnc_hasOwner) then {
			_owner = _b getVariable "owner";
			if(_owner != getplayeruid player) then {
				if(_typecls != "Camp" and _typecls != "Base") then {
					_canplace = false;
				};
			}else{
				if(_typecls == "Camp" or _typecls == "Base") then {
					_canplace = false;
				};
			};
		}else{
			_canplace = false;
		};
	}else{
		if(_typecls != "Camp" and _typecls != "Base") then {
			_canplace = false;
		};
	};
};


if(_typecls == "Base") then {
	_town = _pos call OT_fnc_nearestTown;
	_postown = server getVariable _town;
	_dist = 250;
	if((_postown distance _pos) < _dist) then {_canplace = false};
};



_canplace
