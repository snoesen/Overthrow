_garrison = compileFinal preProcessFileLineNumbers "spawners\militaryGarrison.sqf";
_checkpoints = compileFinal preProcessFileLineNumbers "spawners\militaryCheckpoint.sqf";
{
	_name = _x select 1;
	_pos = _x select 0;
	[_pos,_garrison,[_pos,_name]] call OT_fnc_registerSpawner;	
}foreach(OT_NATOobjectives + OT_NATOcomms);

{
	_pos = getMarkerPos _x;
	[_pos,_checkpoints,[_pos,_x]] call OT_fnc_registerSpawner;	
}foreach(OT_NATO_control);