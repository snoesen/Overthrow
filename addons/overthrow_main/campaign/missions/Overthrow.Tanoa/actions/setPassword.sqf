OT_context = _this select 0;
inputHandler = {
	_val = ctrltext 1400;
	OT_context setVariable ["password",_val,true];
};

["Set password (blank to remove)",""] spawn inputDialog;