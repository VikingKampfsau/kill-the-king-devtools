main()
{
	thread mptype\mptype_ally_sniper::precache();
	thread mptype\mptype_ally_urban_sniper::precache();
	thread mptype\mptype_ally_woodland_sniper::precache();
	thread mptype\mptype_axis_sniper::precache();
	thread mptype\mptype_axis_urban_sniper::precache();
	thread mptype\mptype_axis_woodland_sniper::precache();

	if(getDvar("scr_devtool") == "") setDvar("scr_devtool", 0);

	if( getDvar( "mapname" ) == "mp_background" )
		return; // this isn't required...
		
	maps\mp\gametypes\_callbacksetup::SetupCallbacks();
	level.callbackStartGameType = ::Callback_StartGameType;
	level.callbackPlayerConnect = ::Callback_PlayerConnect;
	level.callbackPlayerDisconnect = ::Callback_PlayerDisconnect;
	level.callbackPlayerDamage = ::Callback_PlayerDamage;
	level.callbackPlayerKilled = ::Callback_PlayerKilled;
	level.callbackPlayerLastStand = ::Callback_PlayerLastStand;
	
	level.script = "";
	level.trigger = undefined;
	level.specMode = false;
	level.triggers = [];
	level.noClip = false;
	
	game["menu_class"] = "class";
	game["menu_class_allies"] = "class_marines";
	game["menu_class_axis"] = "class_opfor";
	game["menu_team"] = "team_marinesopfor";
	
	precacheMenu(game["menu_class"]);
	precacheMenu(game["menu_team"]);
	precacheMenu(game["menu_class_allies"]);
	precacheMenu(game["menu_class_axis"]);
}

Callback_StartGameType()
{
	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	
	level.teamSpawnPoints["axis"] = [];
	level.teamSpawnPoints["allies"] = [];
	
	level.spawnMins = ( 0, 0, 0 );
	level.spawnMaxs = ( 0, 0, 0 );
	
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints( "mp_tdm_spawn_allies_start" );
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints( "mp_tdm_spawn_axis_start" );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( game["defenders"], "mp_tdm_spawn" );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( game["attackers"], "mp_tdm_spawn" );
	
	level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
	setMapCenter( level.mapCenter );
		
	allowed[0] = "war";
	allowed[1] = "bombzone";
	maps\mp\gametypes\_gameobjects::main(allowed);
	
	thread maps\mp\gametypes\_devtools::init();
}


Callback_PlayerConnect()
{
	self.statusicon = "";
	self waittill("begin");
	
	self setclientdvar("g_scriptMainMenu", game["menu_team"]);
	self openMenu(game["menu_team"]);
	
	self setclientdvar("scr_devtool_edit", getDvar("scr_devtool_edit"));
	
	while(1)
	{
		self waittill("menuresponse", menu, response);
	
		if(menu == game["menu_team"] && response == "close_teammenu")
			break;
	
	}

	self thread maps\mp\gametypes\_devtools::initEditor();
}


Callback_PlayerDisconnect()
{
	return;
}


Callback_PlayerLastStand( eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration )
{
	return;
}


Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime)
{
	return;
}


Callback_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration)
{
	return;
}