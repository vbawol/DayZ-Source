private["_serial","_positions","_min","_lootGroup","_iArray","_iItem","_iClass","_iPos","_item","_mags","_qty","_max","_tQty","_canType","_obj","_type","_nearBy","_clean","_unitTypes","_max","_isNoone","_config","_num","_originalPos","_zombieChance","_rnd","_fastRun"];
_obj = 			_this select 0;
_type = 		typeOf _obj;
_config = 		configFile >> "CfgBuildingLoot" >> _type;
_canLoot = 		isClass (_config);
_originalPos = 	getPosATL _obj;

if (_canLoot) then {
	//Get zombie class
	_unitTypes = 	getArray (_config >> "zombieClass");
	_min = 			getNumber (_config >> "maxRoaming");
	_max = 			getNumber (_config >> "minRoaming");
	//Walking Zombies
	_num = round(random _max) max _min; // + round(_max / 3);
	
	//diag_log ("Class: " + _type + " / Zombies: " + str(_unitTypes) + " / Walking: " + str(_num));
	
	for "_i" from 1 to _num do
	{
		[_originalPos,true,_unitTypes] call zombie_generate;
	};
	
	//Add Internal Zombies
	_clean = count ((getPosATL _obj) nearEntities ["zZombie_Base",(sizeOf _type)]) == 0;
	if (_clean) then {
		_positions =	getArray (_config >> "lootPos");
		_zombieChance =	getNumber (_config >> "zombieChance");
		//diag_log format["Building: %1 / Positions: %2 / Chance: %3",_type,_positions,_zombieChance];
		{
			_rnd = random 1;
			if (_rnd < _zombieChance) then {
				//_iPos = _obj modelToWorld _x;
				_iPos = [_originalPos,5,40,20,0,0,0] call BIS_fnc_findSafePos;
				//_iPos = position (_obj);
				_nearBy = count nearestObjects [_iPos , ["zZombie_Base"],1] > 0;
				_nearByPlayer = ({isPlayer _x} count (_iPos  nearEntities ["CAManBase",30])) > 0;
				//_withinRange = _x distance player < 100;
				//diag_log ("BUILDING: " + _type + " / " + str(_nearBy) + " / " + str(_nearByPlayer));
				
				if (!_nearByPlayer and !_nearBy) then {
					[_iPos,false,_unitTypes] call zombie_generate;
				};
			};
		} forEach _positions;
	};

	dayz_buildingMonitor set [count dayz_buildingMonitor,_obj];
};