private _town = (getpos _this) call OT_fnc_nearestTown;
if(isNil "_town") exitWith {[-1,-1,-1,-1]};
private _stability = ((server getVariable format["stability%1",_town]) / 100);
private _population = server getVariable format["population%1",_town];
if(_population > 1000) then {_population = 1000};
_population = (_population / 1000);
private _totaloccupants = 1;

private _baseprice = 400;
private _type = typeof _this;
if !(_type in OT_spawnHouses) then {
	call {
		if(_type in OT_lowPopHouses) exitWith {_baseprice = 1000;_totaloccupants=6};
		if(_type in OT_mansions) exitWith {_baseprice = 50000;_totaloccupants=8;};
		if(_type in OT_medPopHouses) exitWith {_baseprice = 2000;_totaloccupants=10};
		if(_type in OT_highPopHouses) exitWith {_baseprice = 15000;_totaloccupants=15};
		if(_type in OT_hugePopHouses) exitWith {_baseprice = 50000;_totaloccupants=40};
		if(_type == OT_warehouse) exitWith {_baseprice = 3000;_totaloccupants=0};
	};
};
private _price = round(_baseprice + ((_baseprice * _stability * _population) * (1+OT_standardMarkup)));
private _sell = round(_baseprice + (_baseprice * _stability * _population));
private _lease = round((_stability * _population) * (_baseprice * _totaloccupants * 0.05));
if !(_town in (server getvariable ["NATOabandoned",[]])) then {_lease = round(_lease * 0.4)};
private _diff = server getVariable ["OT_difficulty",1];
if(_diff == 0) then {_lease = round(_lease * 1.2)};
if(_diff == 2) then {_lease = round(_lease * 0.8)};
if(_lease < 1) then {_lease = 1};
[_price,_sell,_lease,_totaloccupants]
