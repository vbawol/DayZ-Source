/* THIS FILE IS NOT USED ANYMORE
private["_agent","_id","_isSomeone","_isAlive","_target","_targetPos","_myDest"];

_agent = _this select 0;

//Add handlers
 //_id = _agent addeventhandler ["HandleDamage",{_this call local_zombieDamage}];

//Loop behaviour
_isSomeone = ({_x distance _agent < dayz_canDelete} count playableUnits) > 0;
_isAlive = alive _agent;
while {_isAlive and _isSomeone} do {
//NO TARGET
	_agent disableAI "FSM";
	_target = objNull;
	_targetPos = [];

	//Spawn roaming script (individual to unit)
	_myDest = getPosATL _agent;

	//Loop looking for targets
	while {isNull _target and _isAlive and _isSomeone} do {
		_isAlive = alive _agent;
		_isSomeone = ({_x distance _agent < dayz_canDelete} count playableUnits) > 0;
		_target = _agent call zombie_findTargetAgent;
		if (_isAlive and (_agent distance _myDest < 5)) then {
			[_agent,_myDest] call zombie_loiter;
		};
		_agent forceSpeed 2;
		sleep 1;
	};

//CHASE TARGET

	//Leader cries out
	[_agent,"attack",0,false] call dayz_zombieSpeak;

	//Start Movement loop
	while {!isNull _target and _isAlive and _isSomeone} do {
		_target = _agent call zombie_findTargetAgent;
		_isAlive = alive _agent;
		_targetPos = getPosATL _target;
		//Move to target
		_agent moveTo _targetPos;
		_agent forceSpeed 8;
		sleep 1;
	};
//LOOP
	_agent setVariable ["targets",[], true];
	_isAlive = alive _agent;
	sleep 1;
};

//Wait for a while then cleanup
sleep 5;
deleteVehicle _agent;
*/
