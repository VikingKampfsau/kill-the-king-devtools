/*---------------------------------------------------------------------------
|///////////////////////////////////////////////////////////////////////////|
|///\  \/////////  ///|  |//|  |///  ///|  |//|   \////|  |//|          |///|
|////\  \///////  ////|  |//|  |//  ////|  |//|    \///|  |//|  ________|///|
|/////\  \/////  /////|  |//|  |/  /////|  |//|  \  \//|  |//|  |///////////|
|//////\  \///  //////|  |//|     //////|  |//|  |\  \/|  |//|  |//|    |///|
|///////\  \/  ///////|  |//|     \/////|  |//|  |/\  \|  |//|  |//|_   |///|
|////////\    ////////|  |//|  |\  \////|  |//|  |//\  \  |//|  |////|  |///|
|/////////\  /////////|  |//|  |/\  \///|  |//|  |///\    |//|          |///|
|//////////\//////////|__|//|__|//\__\//|__|//|__|////\___|//|__________|///|
|///////////////////////////////////////////////////////////////////////////|
|---------------------------------------------------------------------------|
|				   Do not copy or modify without permission				    |
|--------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------|
|				To use the tools the gametype has to be DM					|
|--------------------------------------------------------------------------*/

#include maps\mp\gametypes\_export;

init()
{
	precacheModel("com_bomb_objective_obj");
	precacheModel("com_steel_ladder");

	setDvar("player_sustainAmmo", 1);

	if(getDvar("scr_devtool") == "") setDvar("scr_devtool", 0);
	if(getDvar("scr_devtool_flypath") == "") setDvar("scr_devtool_flypath", 1);
	if(getDvar("scr_devtool_edit") == "") setDvar("scr_devtool_edit", "ladders");
	
	if(!getDvarInt("scr_devtool"))
		return;
	
	level.ktkDeveloper = [];
	
	thread maps\mp\gametypes\_bombzone::init();
	
	if(getDvarInt("scr_devtool_flypath"))
	{
		thread drawAC130FlyRadius();
		thread drawHeliFlyPath();
	}
		
	if(getDvar("scr_devtool_edit") == "ladders")
	{
		level.ladder = [];
		level.laddermodel = [];
		
		maps\_ladderPositions::initLadders();
	}
	else if(getDvar("scr_devtool_edit") == "blockers")
	{
		level.blockers = [];
		level.blockers = maps\_antiglitchPositions::initBlockers();
	}
	else if(getDvar("scr_devtool_edit") == "triggers")
	{
		level.glitchtriggers = [];
		level.glitchtriggers = maps\_antiglitchPositions::initGlitchTriggers();
	}
	else if(getDvar("scr_devtool_edit") == "lasers")
	{
		level.glitchtrace = [];
		level.glitchtrace = maps\_antiglitchPositions::initGlitchLasers();
	}
	else if(getDvar("scr_devtool_edit") == "waypoints")
	{
		maps\_waypoints::loadPezBotWaypoints();
		maps\_waypoints::loadWaypoints();
		
		if(!isDefined(level.waypoints))
			level.waypoints = [];
		
		thread drawSpawns();
		thread drawWP();
	}
}

initEditor()
{
	self setClientDvars( "cg_drawSpectatorMessages", 1,
						 "ui_hud_hardcore", 0,
						 "player_sprintTime", 3,
						 "ui_uav_client", 0,
						 "g_scriptMainMenu", "class_marines",
						 "developer", 1,
						 "developer_script", 1);
	
	self.sessionteam = "allies";
	self takeAllWeapons();
	self detachall();
	
	if(game["allies_soldiertype"] == "desert")
		self mptype\mptype_ally_sniper::main();
	else if(game["allies_soldiertype"] == "urban")
		self mptype\mptype_ally_urban_sniper::main();
	else
		self mptype\mptype_ally_woodland_sniper::main();
	
	/*if(game["axis_soldiertype"] == "desert")
		self mptype\mptype_axis_sniper::main();
	else if(game["allies_soldiertype"] == "urban")
		self mptype\mptype_axis_urban_sniper::main();
	else
		self mptype\mptype_axis_woodland_sniper::main();*/
	
	self.sessionstate = "playing";
	self.maxhealth = 100;
	self.health = 100;
	
	spawns = getentarray("mp_tdm_spawn", "classname");
	spawn = spawns[randomint(spawns.size)];
	self spawn( spawn.origin, spawn.angles );
	
	self iPrintLnBold("^7Press ^3ESC ^7to see the controls!");
	
	if(getDvar("scr_devtool_edit") == "ladders")
		self thread LadderPlaceTool();
	else if(getDvar("scr_devtool_edit") == "blockers")
		self thread BlockerPlaceTool();
	else if(getDvar("scr_devtool_edit") == "triggers")
		self thread BlockerPlaceTool();
	else if(getDvar("scr_devtool_edit") == "lasers")
		self thread LaserPlaceTool();
	else if(getDvar("scr_devtool_edit") == "waypoints")
		self thread WaypointTool();
		
	self thread monitorExport();
	
	level.ktkDeveloper[level.ktkDeveloper.size] = self;
}

monitorExport()
{
	self endon("disconnect");
	
	status = 0;
	while(1)
	{
		self waittill("menuresponse", menu, response);
		
		if(response == "ktk_devtool_export")
		{
			self setClientDvar("scr_devtool_status", "exporting");
		
			if(getDvar("scr_devtool_edit") == "ladders")
				status = ExportLadders();
			else if(getDvar("scr_devtool_edit") == "blockers")
				status = saveBlockers();
			else if(getDvar("scr_devtool_edit") == "triggers")
				status = saveBlockers();
			else if(getDvar("scr_devtool_edit") == "lasers")
				status = ExportLasers();
			else if(getDvar("scr_devtool_edit") == "waypoints")
				status = SaveStaticWaypoints();
				
			self setClientDvar("scr_devtool_status", "nothing");
			
			if(status)
				self playLocalSound("mp_level_up");

			self closeMenu();
			self closeInGameMenu();
				
			continue;
		}
		
		if(response == "ktk_devtool_autolinkwps")
		{
			if(getDvar("scr_devtool_edit") == "waypoints")
				status = AutoLinkAllWaypoins();
			
			if(status)
				self playLocalSound("mp_level_up");

			self closeMenu();
			self closeInGameMenu();
				
			continue;
		}
	}
}

/*--------------------------------------------------------------------------|
|							Some used functions								|
|--------------------------------------------------------------------------*/

float(float)
{
	setDvar("float", float);
	return getDvarFloat("float");
}

GetSkyHeight()
{
	if(isDefined(level.heli_paths))
	{
		heli_nodes = [];
		heli_nodes[0] = getent("heli_loop_start", "targetname");
		height = heli_nodes[0].origin[2];
		
		for(i=1;i<20;i++)
		{
			heli_nodes[i] = getent(heli_nodes[i-1].target, "targetname");
			
			if(!isDefined(heli_nodes[i]))
				break;
			
			if(heli_nodes[i].target == heli_nodes[0].target)
				break;
			
			if(heli_nodes[i].origin[2] >= height)
				height = heli_nodes[i].origin[2];
		}
		
		return height;
	}
	
	trace = BulletTrace((level.mapCenter[0], level.mapCenter[1], 100000), level.mapCenter, false, undefined);
	trace = BulletTrace((level.mapCenter[0], level.mapCenter[1], 1000), trace["position"], false, undefined);
	
	if((trace["position"][2] - level.mapCenter[2]) > 1600)
		trace["position"] = (trace["position"][0], trace["position"][1], 1600);

	return (trace["position"][2] - 100);
}

/*--------------------------------------------------------------------------|
|							DevTool to place ladders						|
|--------------------------------------------------------------------------*/
spawnLadderModel(origin, angles)
{
	slot = level.laddermodel.size;
	level.laddermodel[slot] = spawn("script_model", origin);
	level.laddermodel[slot].angles = angles;
	level.laddermodel[slot] setModel("com_steel_ladder");
}

spawnLadderTrigger(num, origin, angles, distance, elevation, width, height)
{
	if(!isDefined(height))
		height = width;

	//for climbing up
	level.ladder[num] = spawn("trigger_radius", origin, 0, width, height);
	level.ladder[num].angle = angles;
	level.ladder[num].dist = distance;
	level.ladder[num].elevation = elevation;
	level.ladder[num].angles = (0,angles,0);
	
	//for climbing down
	level.ladder[num].down = spawn("trigger_radius", origin, 0, width, height);
	level.ladder[num].down.origin = origin + (0,0,elevation) + anglesToForward((0, angles, 0)) * distance;
	level.ladder[num].down.angle = angles * -1;
	level.ladder[num].down.dist = distance * -1;
	level.ladder[num].down.elevation = elevation * -1 + 10; //10 up so the player does not go into the ground
	level.ladder[num].down.angles = (0,angles,0);
}

LadderPlaceTool()
{
	self endon("disconnect");
	self endon("death");

	/*self iPrintLnBold("^3[{+attack}] ^7= Place new ladder ^3OR ^7change height (up)");
	self iPrintLnBold("^3[{+toggleads}] ^7= Change height (down)");
	self iPrintLnBold("^3[{+frag}] ^7= Rotate");
	self iPrintLnBold("^3[{+activate}] ^7= Edit the closest ladder");
	self iPrintLnBold("^3[{+smoke}] ^7= Define bottom/top position");
	self iPrintLnBold("^3[{+melee}] ^7= Save in log");*/

	if(!isDefined(level.laddermodel))
		level.laddermodel = [];
	
	if(isDefined(level.ladder) && level.ladder.size > 0)
	{
		for(i=0;i<level.ladder.size;i++)
		{
			level.ladder[i].ground = level.ladder[i].origin;
			level.ladder[i] thread DebugClimbPath();
		}
	}
	
	player = self;
	ground = undefined;
	curLadder = undefined;
	placeNewLadder = true;

	while(1)
	{
		wait .05;
		
		if(player AttackButtonPressed())
		{
			if(placeNewLadder)
			{
				target = PhysicsTrace(player getEye(), player getEye() + AnglesToForward(player getPlayerAngles())*99999);
			
				if(isDefined(target))
				{
					if(isDefined(curLadder))
						curLadder++;
					else
					{
						if(!level.laddermodel.size)
							curLadder = 0;
						else
							curLadder = level.laddermodel.size;
					}
					
					placeNewLadder = false;
					spawnLadderModel(target, player.angles + (0,180,180));
				}
				
				while(player AttackButtonPressed())
					wait .05;
			}
			
			while(player AttackButtonPressed())
			{
				if(isDefined(level.laddermodel[curLadder]))
					level.laddermodel[curLadder].origin += (0,0,1);	
					
				wait .05;
			}
		}
		else if(player ADSButtonPressed())
		{
			if(placeNewLadder || !isDefined(curLadder))
				continue;

			while(player ADSButtonPressed())
			{
				if(isDefined(level.laddermodel[curLadder]))
					level.laddermodel[curLadder].origin -= (0,0,1);	
					
				wait .05;
			}			
		}
		else if(player FragButtonPressed())
		{
			if(placeNewLadder || !isDefined(curLadder))
				continue;

			while(player FragButtonPressed())
			{
				if(isDefined(level.laddermodel[curLadder]))
				{
					level.laddermodel[curLadder].angles += (0,1,0);
				
					if(level.laddermodel[curLadder].angles[1] >= 360)
						level.laddermodel[curLadder].angles = (level.laddermodel[curLadder].angles[0], 0, level.laddermodel[curLadder].angles[2]);
				}
					
				wait .05;
			}	
		}
		else if(player SecondaryOffhandButtonPressed())
		{
			if(placeNewLadder || !isDefined(curLadder))
				continue;

			if(isDefined(level.laddermodel[curLadder]))
			{
				if(!isDefined(ground))
				{
					ground = player.origin[2];
					level.laddermodel[curLadder].ground = player.origin;
					level.laddermodel[curLadder].elevation = 205 - Distance(level.laddermodel[curLadder].origin, (level.laddermodel[curLadder].origin[0], level.laddermodel[curLadder].origin[1], ground));
					iPrintLn("Bottom of the ladder defined.");					
				}
				else
				{
					ground = undefined;
					level.laddermodel[curLadder].dist = Distance(player.origin, (level.laddermodel[curLadder].origin[0], level.laddermodel[curLadder].origin[1], player.origin[2]));
					iPrintLn("Mantle distance at the top of the ladder defined.");
				}
			}

			while(player SecondaryOffhandButtonPressed())
				wait .05;
		}
		else if(player UseButtonPressed())
		{
			if(placeNewLadder)
			{
				if(level.laddermodel.size > 0)
				{
					placeNewLadder = false;
					
					tempDist = 9999999;
					for(i=0;i<level.laddermodel.size;i++)
					{
						if(Distance(player.origin, level.laddermodel[i].origin) <= tempDist && Distance(player.origin, level.laddermodel[i].origin) <= 200)
						{
							tempDist = Distance(player.origin, level.laddermodel[i].origin);
							curLadder = i;
						}
					}
				}
				
				if(!isDefined(curLadder) || !isDefined(level.laddermodel[curLadder]))
				{
					iPrintLn("There is no ladder to pick up.");
					placeNewLadder = true;
				}
				else
				{
					if(isDefined(curLadder) && isDefined(level.laddermodel[curLadder]))
					{
						iPrintLn("Ladder for edit picked up.");
						level.laddermodel[curLadder] notify("ladderpickup");
					}
					else
					{
						iPrintLn("There is no ladder to pick up.");
						placeNewLadder = true;
					}
				}
			}
			else
			{
				if(isDefined(curLadder) && isDefined(level.laddermodel[curLadder]))
				{
					placeNewLadder = true;
					level.laddermodel[curLadder] thread DebugClimbPath();
					iPrintLn("Ladder placed.");
				}
			}
			
			while(player UseButtonPressed())			
				wait .05;
		}
		/*else if(player MeleeButtonPressed())
		{
			ExportLadders();
		
			while(player MeleeButtonPressed())			
				wait .05;
		}*/
	}
}

DebugClimbPath()
{
	self endon("ladderpickup");
	
	if(!isDefined(self.ground) || !isDefined(self.elevation) || !isDefined(self.dist))
		return;
	
	color = (0,0,1);
	while(1)
	{
		line(self.ground, self.ground + (0,0,self.elevation), color);
		line(self.ground + (0,0,self.elevation), self.ground + (0,0,self.elevation) - AnglesToForward((0,self.angles[1],0))*self.dist, color);
		wait .05;
	}
}

/*--------------------------------------------------------------------------|
|							DevTool for Antiglitch							|
|							BlockerPlaceTool by Bipo						|
|--------------------------------------------------------------------------*/
BlockerPlaceTool() {
	/*self iPrintLnBold("^3[{+attack}] ^7= Start new blocker ^3OR ^7finish current");
	self iPrintLnBold("^3[{+frag}] ^7= Delete current blocker");
	self iPrintLnBold("^3[{+melee}] ^7= Save in log");*/

	fbp = 0;
	ubp = 0;
	lmbp = 0;
	mbp = 0;
	while (1) {
		if (self usebuttonpressed()){
			if (!ubp) {
				//free button
				ubp = 1;
			}
		}
		else {ubp = 0;}
		if (self fragbuttonpressed()){
			if (!fbp) {
				if (isdefined(level.trigger)) {
					level.trigger delete();
					iPrintLn("Blocker cancelled!");
				}
				fbp = 1;
			}
		}
		else { fbp = 0; }
		if (self attackbuttonpressed()){
			if (!lmbp) {
				placeBlockNode(self.origin);
				lmbp = 1;
			}
		}
		else { lmbp = 0; }
		/*if (self meleebuttonpressed()){
			if (!mbp) {
				saveBlockers();
				mbp = 1;
			}
		}
		else { mbp = 0; }*/
		wait 0.05;
	}
}

placeBlockNode(origin) {
	if (!isdefined(level.trigger)) {
		trigger = spawn("trigger_radius", self.origin, 0, 100, 100);
		trigger.radius = 10;
		trigger.height = 10;
		trigger thread drawRadius((1,0,0));
		level.trigger = trigger;
		self thread updateRadius();
	}
	else
	{

		iPrintLn("Blocker placed!");
		trigger = spawn("trigger_radius", level.trigger.origin, 0, level.trigger.radius, level.trigger.height);
		trigger.radius = level.trigger.radius;
		trigger.height = level.trigger.height;
		level.triggers[level.triggers.size] = trigger;
		trigger thread drawRadius((1,1,1));
		trigger setcontents(1);
		level.trigger delete();
	}
}

updateRadius() {
	self endon("death");
	self endon("quitdraw");
	
	if (getdvar("max_radius")=="")
	setdvar("max_radius", 500);
	
	while (isdefined(level.trigger)) {
		level.trigger.radius = distance2d(level.trigger.origin,self.origin);
		if (level.trigger.radius > getdvarint("max_radius"))
		level.trigger.radius = getdvarint("max_radius");
		level.trigger.height = self.origin[2] + 52 - level.trigger.origin[2];
		wait 0.05;
	}
}

drawRadius(color) {
	self endon("death");
	self endon("quitdraw");
	precision = 10;
	angle = 0;
	dif = (cos(angle)*self.radius, sin(angle)*self.radius, 0);
	while (1)
	{
		for (i=0; i<precision; i++) 
		{
			difup = (0, 0, self.height);
			line(self.origin + dif, self.origin - dif, color);
			line(self.origin + dif + difup, self.origin - dif + difup, color);
			
			line(self.origin + dif, self.origin + dif + difup, color);
			line(self.origin - dif, self.origin - dif + difup, color);
			
			predif = dif;
			angle += 180/precision;
			dif = (cos(angle)*self.radius, sin(angle)*self.radius, 0);
			
			line(self.origin + predif, self.origin + dif, color);
			line(self.origin - predif, self.origin - dif, color);
			
			line(self.origin + predif + difup, self.origin + dif + difup, color);
			line(self.origin - predif + difup, self.origin - dif + difup, color);
			
		}
		wait .05;
	}
}

/*--------------------------------------------------------------------------|
|							Laser Detector Lines							|
|--------------------------------------------------------------------------*/
LaserPlaceTool()
{
	self endon("disconnect");
	self endon("death");

	/*self iPrintLnBold("^3[{+attack}] ^7= Place laser start/end");
	self iPrintLnBold("^3[{+activate}] ^7= Delete current laser");
	self iPrintLnBold("^3[{+melee}] ^7= Save in log");*/
	
	player = self;
	curLaser = undefined;
	placeNewLaser = true;

	while(1)
	{
		wait .05;
		
		if(player AttackButtonPressed())
		{
			target = PhysicsTrace(player getEye(), player getEye() + AnglesToForward(player getPlayerAngles())*99999);
			
			if(isDefined(target))
			{
				if(placeNewLaser)
				{
					if(isDefined(curLaser))
						curLaser++;
					else
					{
						if(!level.glitchtrace.size)
							curLaser = 0;
						else
							curLaser = level.glitchtrace.size;
					}
					
					placeNewLaser = false;					
					level.glitchtrace[curLaser] = spawn("script_origin", target);
					
					iPrintLn("Laser start defined.");
				}
				else
				{
					placeNewLaser = true;					
					level.glitchtrace[curLaser].end = spawn("script_origin", target);
					level.glitchtrace[curLaser] thread drawLaser();

					iPrintLn("Laser end defined.");
				}
			}
			
			while(player AttackButtonPressed())					
				wait .05;
		}
		else if(player UseButtonPressed())
		{
			if(!isDefined(curLaser))
				continue;
		
			if(isDefined(level.glitchtrace[curLaser]))
			{
				level.glitchtrace[curLaser] notify("laserdeleted");
				
				if(isDefined(level.glitchtrace[curLaser].end))
					level.glitchtrace[curLaser].end delete();
				
				if(isDefined(level.glitchtrace[curLaser]))
					level.glitchtrace[curLaser] delete();
					
				curLaser--;
			}
		
			while(player UseButtonPressed())			
				wait .05;
		}
		/*else if(player MeleeButtonPressed())
		{
			ExportLasers();
		
			while(player MeleeButtonPressed())			
				wait .05;
		}*/
	}
}

drawLaser()
{
	self endon("laserdeleted");
	
	color = (1,0,0);
	while(1)
	{
		line(self.origin, self.end.origin, color);
		wait .05;
	}
}
/*--------------------------------------------------------------------------|
|					DevTool to show heli/ac130 flypath						|
|--------------------------------------------------------------------------*/
drawAC130FlyRadius()
{
	level.ac130FlyRadius = 1500;

	wait 5;

	angle = 0;
	precision = 10;
	color = (0,1,0);
	origin = level.mapCenter + (0, 0, GetSkyHeight());
	radius = Distance(level.spawnMins, level.mapCenter);
	dif = (cos(angle)*radius, sin(angle)*radius, 0);
	
	if(radius > level.ac130FlyRadius)
		radius = level.ac130FlyRadius;
	
	while(getDvarInt("scr_devtool") && getDvarInt("scr_devtool_flypath"))
	{
		for(i=0;i<precision;i++)
		{
			predif = dif;
			angle += 180/precision;
			dif = (cos(angle)*radius, sin(angle)*radius, 0);
			
			line(origin + predif, origin + dif, color);
			line(origin - predif, origin - dif, color);
			
			line(origin + predif, origin + dif, color);
			line(origin - predif, origin - dif, color);
			
		}
		wait .05;
	}
}

drawHeliFlyPath()
{
	maps\mp\_helicopter::init();
	
	if(!isDefined(level.heli_loop_paths) || !level.heli_loop_paths.size)
	{
		iPrintLnBold("This map has no heli path");
		return;
	}

	currentnode = level.heli_loop_paths[0];
	
	while(isDefined(currentnode.target))
	{
		nextnode = getEnt(currentnode.target, "targetname");
		
		thread debugHeliFlyPath(currentnode, nextnode);
		
		if(!isDefined(nextnode.target) || nextnode == level.heli_loop_paths[0])
			break;
		
		currentnode = nextnode;
		wait .05;
	}
}

debugHeliFlyPath(currentnode, nextnode)
{
	color = (0,1,0);
	while(getDvarInt("scr_devtool") && getDvarInt("scr_devtool_flypath"))
	{
		line(currentnode.origin, nextnode.origin, color);
		wait .05;
	}
}

/*--------------------------------------------------------------------------|
|					DevTool to setup the waypoints for bots					|
|--------------------------------------------------------------------------*/
drawWP()
{
	if (getdvar("max_radius")=="")
		setdvar("max_radius", 500);

	max_radius = getdvarint("max_radius");

	while(1)
	{
		wait 0.05;
	
		if(!isDefined(level.waypoints) || level.waypoints.size == 0)
			continue;
	
		//only draw it when a player is close to it
		if(!isDefined(level.ktkDeveloper) || level.ktkDeveloper.size <= 0)
			continue;
	
		for(i=0;i<level.waypoints.size;i++)
		{
			for(z=0;z<level.ktkDeveloper.size;z++)
			{
				if(!isDefined(level.ktkDeveloper[z]))
					continue;

				if(Distance(level.ktkDeveloper[z].origin, level.waypoints[i].origin) <= max_radius)
				{
					line(level.waypoints[i].origin, level.waypoints[i].origin + (0,0,96), (0,1,0), 1);
				
					for(j=0;j<level.waypoints[i].childCount;j++)
						line(level.waypoints[i].origin, level.waypoints[level.waypoints[i].children[j]].origin, (0,0,1), 1);
				}
			}
		}
	}
}

drawSpawns()
{
	entities = getEntArray();

	for(i=0;i<entities.size;i++)
	{
		if(isDefined(entities[i].classname))
		{
			switch(entities[i].classname)
			{
				case "mp_tdm_spawn":
				case "mp_tdm_spawn_axis_start":
				case "mp_tdm_spawn_allies_start":
					spawnModel = spawn("script_model", entities[i].origin);
					spawnModel.angles = entities[i].angles;
					
					if(game["allies_soldiertype"] == "desert")
						spawnModel setModel("body_mp_usmc_sniper");
					else if(game["allies_soldiertype"] == "urban")
						spawnModel setModel("body_mp_sas_urban_sniper");
					else
						spawnModel setModel("body_mp_usmc_woodland_sniper");

				default: break;
			}
		}
	}
}

WaypointTool()
{
	self endon("disconnect");

	/*self iPrintLnBold("^3[{+attack}] ^7= Add new waypoint");
	self iPrintLnBold("^3[{+toggleads}] ^7= Change waypoint type");
	self iPrintLnBold("^3[{+activate}] ^7= Link waypoints");
	self iPrintLnBold("^3[{+smoke}] ^7= Un-Link waypoints");
	self iPrintLnBold("^3[{+frag}] ^7= Delete closest waypoint");
	self iPrintLnBold("^3[{+melee}] ^7= Save waypoints to log");*/

	if(!isDefined(level.waypoints))
		level.waypoints = [];
	
    level.wpToLink = -1;
    level.wpToChange = -1;
    level.linkSpamTimer = gettime();
    level.saveSpamTimer = gettime();
    level.changeSpamTimer = gettime();
	
	while(1)
	{
		if(self attackbuttonpressed())
		{
			self AddWaypoint();
		
			while(self attackbuttonpressed())
				wait .05;
		}
		
		/*if(self adsbuttonpressed())
		{
			//self ChangeWaypointType();
			AutoLinkAllWaypoins()
		
			while(self adsbuttonpressed())
				wait .05;
		}*/
		
		if(self useButtonPressed())
		{
			self LinkWaypoint();
		
			while(self useButtonPressed())
				wait .05;
		}
		
		if(self secondaryoffhandbuttonpressed())
		{
			self UnLinkWaypoint();
		
			while(self secondaryoffhandbuttonpressed())
				wait .05;
		}
		
		if(self fragbuttonpressed())
		{
			self DeleteWaypoint();
		
			while(self fragbuttonpressed())
				wait .05;
		}
		
		/*if(self meleebuttonpressed())
		{
			self SaveStaticWaypoints();
		
			while(self meleebuttonpressed())
				wait .05;
		}*/
		
		wait 0.05;
	}
}

AddWaypoint()
{
	pos = self.origin;

 	if(isDefined(level.waypoints) && level.waypoints.size > 0)
	{
		for(i=0;i<level.waypoints.size;i++)
		{
			if(Distance(level.waypoints[i].origin, pos) <= 30.0)
				return;
		}
	}

	level.waypointCount = level.waypoints.size;
	level.waypoints[level.waypointCount] = spawnstruct();
    level.waypoints[level.waypointCount].origin = pos;
    level.waypoints[level.waypointCount].type = "stand";
    level.waypoints[level.waypointCount].children = [];
    level.waypoints[level.waypointCount].childCount = 0;

    iprintln("Added Waypoint " + level.waypointCount); 
}

ChangeWaypointType()
{
 	if(!isDefined(level.waypoints) || level.waypoints.size == 0)
		return;

    if((gettime()-level.changeSpamTimer) < 1000)
		return;

    level.changeSpamTimer = gettime();
    wpTochange = -1;
	pos = self.origin;
  
 	if(!isDefined(level.waypoints) || level.waypoints.size == 0)
		return;
  
    for(i=0;i<level.waypoints.size;i++)
    {
        if(Distance(level.waypoints[i].origin, pos) <= 30.0)
        {
            wpTochange = i;
            break;
        }
    }
  
	if(wpTochange != -1)
    {
        if(level.waypoints[wpTochange].type == "stand")
        {
			iprintln(&"DEBUG_CHANGE_CLIMB");
            level.waypoints[wpTochange].type = "climb";
			level.waypoints[wpTochange].angles = self getplayerangles();
			return;
        }
		
		if(level.waypoints[wpTochange].type == "climb")
        { 
			iprintln(&"DEBUG_CHANGE_NORMAL");
            level.waypoints[wpTochange].type = "stand";
			level.waypoints[wpTochange].angles = -1;
			return;
        }
    }
}

DeleteWaypoint()
{
 	if(!isDefined(level.waypoints) || level.waypoints.size == 0)
		return;

	pos = self.origin;
    for(i=0;i<level.waypoints.size;i++)
    {
        if(Distance(level.waypoints[i].origin, pos) <= 30.0)
        {
			//remove all links in children
            //for each child c
            for(c=0;c<level.waypoints[i].childCount;c++)
            {
                //remove links to its parent i
                for(c2=0;c2<level.waypoints[level.waypoints[i].children[c]].childCount;c2++)
                {
                    // child of i has a link to i as one of its children, so remove it
                    if(level.waypoints[level.waypoints[i].children[c]].children[c2] == i)
                    {
                        //remove entry by shuffling list over top of entry
                        for(c3 = c2; c3 < level.waypoints[level.waypoints[i].children[c]].childCount-1; c3++)
                            level.waypoints[level.waypoints[i].children[c]].children[c3] = level.waypoints[level.waypoints[i].children[c]].children[c3+1];

                        //removed child
                        level.waypoints[level.waypoints[i].children[c]].childCount--;
                        break;
                    }
                }
            }
      
			//remove waypoint from list
			for(x=i;x<level.waypoints.size;x++)
				level.waypoints[x] = level.waypoints[x+1];
	  
            //reassign all child links to their correct values
            for(r=0;r<level.waypoints.size;r++)
            {
                for(c=0;c<level.waypoints[r].childCount;c++)
                {
                    if(level.waypoints[r].children[c] > i)
                        level.waypoints[r].children[c]--;
                }
            }
			
            iprintln("Deleted Waypoint " + i);
            return;
        }
    }
}

LinkWaypoint()
{
 	if(!isDefined(level.waypoints) || level.waypoints.size == 0)
		return;

    //dont spam linkage
    if((gettime()-level.linkSpamTimer) < 1000)
        return;

    level.linkSpamTimer = gettime();
    wpToLink = -1;
	pos = self.origin;
  
    for(i=0;i<level.waypoints.size;i++)
    {
        if(Distance(level.waypoints[i].origin, pos) <= 30.0)
        {
            wpToLink = i;
            break;
        }
    }
  
    //if the nearest waypoint is valid
    if(wpToLink != -1)
    {
        //if we have already pressed link on another waypoint, then link them up
        if(level.wpToLink != -1 && level.wpToLink != wpToLink)
        {
            level.waypoints[level.wpToLink].children[level.waypoints[level.wpToLink].childcount] = wpToLink;
            level.waypoints[level.wpToLink].childcount++;
      
            level.waypoints[wpToLink].children[level.waypoints[wpToLink].childcount] = level.wpToLink;
            level.waypoints[wpToLink].childcount++;
      
            iprintln("Waypoint " + wpToLink + " Linked to " + level.wpToLink);
            level.wpToLink = -1;
        }
        else //otherwise store the first link point
        {
            level.wpToLink = wpToLink;
            iprintln("Waypoint Link Started");
        }
    }
    else
    {
        level.wpToLink = -1;
        iprintln("Waypoint Link Cancelled");
    }
}

UnLinkWaypoint()
{
 	if(!isDefined(level.waypoints) || level.waypoints.size == 0)
		return;

    //dont spam linkage
    if((gettime()-level.linkSpamTimer) < 1000)
        return;

    level.linkSpamTimer = gettime();
    wpToLink = -1;
	pos = self.origin;
  
    for(i=0;i<level.waypoints.size;i++)
    {
		if(Distance(level.waypoints[i].origin, pos) <= 30.0)
        {
            wpToLink = i;
            break;
        }
    }
  
    //if the nearest waypoint is valid
    if(wpToLink != -1)
    {
        //if we have already pressed link on another waypoint, then break the link
        if(level.wpToLink != -1 && level.wpToLink != wpToLink)
        {
            //do first waypoint
            for(i=0;i<level.waypoints[level.wpToLink].childCount;i++)
            {
                if(level.waypoints[level.wpToLink].children[i] == wpToLink)
                {
                    //shuffle list down
                    for(c=i;c<level.waypoints[level.wpToLink].childCount-1;c++)
                        level.waypoints[level.wpToLink].children[c] = level.waypoints[level.wpToLink].children[c+1];

                    level.waypoints[level.wpToLink].childCount--;
                    break;
                }
            }
      
            //do second waypoint  
            for(i=0;i<level.waypoints[wpToLink].childCount;i++)
            {
                if(level.waypoints[wpToLink].children[i] == level.wpToLink)
                {
                    //shuffle list down
                    for(c=i;c<level.waypoints[wpToLink].childCount-1;c++)
                        level.waypoints[wpToLink].children[c] = level.waypoints[wpToLink].children[c+1];

                    level.waypoints[wpToLink].childCount--;
                    break;
                }
            }
      
            iprintln("Waypoint " + wpToLink + " Broken to " + level.wpToLink);
            level.wpToLink = -1;
        }
        else //otherwise store the first link point
        {
            level.wpToLink = wpToLink;
            iprintln("Waypoint De-Link Started");
        }
    }
    else
    {
        level.wpToLink = -1;
        iprintln("Waypoint De-Link Cancelled");
    }
}

AutoLinkAllWaypoins()
{
	if(!isDefined(level.waypointCount) || level.waypointCount < 2)
	{
		iPrintLnBold("Not enough waypoints to link!");
		return 0;
	}

	iPrintLnBold("Creating waypoint connections!");

	//Loop through all waypoints
	for(i=0;i<level.waypointCount;i++)
	{
		if(i == int(i/100))
			wait .05;
	
		//Check if it's linkable with any other waypoint
		for(j=0;j<level.waypointCount;j++)
		{
			linkWaypoints = true;
	
			if(j == int(j/100))
				wait .05;
		
			if(j != i)
			{		
				//check if i is already linked to j
				linkExists = false;
				if(level.waypoints[i].childCount > 0)
				{
					for(c=0;c<level.waypoints[i].childCount;c++)
					{
						if(level.waypoints[i].children[c] == j)
						{
							linkExists = true;
							break;
						}
					}
				}
				
				//skip on existing links
				if(!linkExists)
				{
					start = level.waypoints[i].origin + (0,0,5);
					target = level.waypoints[j].origin + (0,0,5);
					
					//check if the path to j is free
					if(PlayerPhysicsTrace(start, target) != target)
						linkWaypoints = false;
					else
					{
						//check if the way to j is passable
						passablePath = true;
							
						lastOffset = 0;
						tempLastOffset = undefined;						
						for(t=1;t<floor(Distance2d(start, target)/5);t++)
						{					
							pos = start + AnglesToForward(VectorToAngles(target - start))*5*t;
							trace = BulletTrace(pos, pos - (0,0,10000), false, undefined);
							
							if(!isDefined(trace["position"]))
							{
								passablePath = false;
								break;
							}
							
							offset = abs(abs(pos[2]) - abs(trace["position"][2]));
							tempLastOffset = abs(offset - lastOffset);
								
							if(!isDefined(tempLastOffset) || tempLastOffset > 10)
							{
								passablePath = false;
								break;
							}
								
							lastOffset = tempLastOffset;
							tempLastOffset = undefined;
						}
					
						//skip when the way to j is unpassable
						if(!passablePath)
							linkWaypoints = false;
							
						//check the distance
						if(Distance(start, target) > 1000)
							linkWaypoints = false;
					}

					//link the waypoint i and j
					if(linkWaypoints)
					{
						level.waypoints[i].children[level.waypoints[i].childcount] = j;
						level.waypoints[i].childcount++;
				  
						level.waypoints[j].children[level.waypoints[j].childcount] = i;
						level.waypoints[j].childcount++;
					}
				}
			}
		}
	}
	
	iPrintLnBold(level.waypointCount + " Waypoints processed.");
	iPrintLnBold("Please check the created connections!");
	iPrintLnBold("Mantles/Ladders have to be added manually!");
	
	return 1;
}

getMissingLinks()
{
	if(isDefined(level.missingLinks) && level.missingLinks.size > 0)
	{
		self thread jumpToUnlinkedWaypoints();
		return;
	}

	iPrintLnBold("Checking waypoint connections!");

	level.missingLinks = [];

	//Loop through all waypoints
	for(i=0;i<level.waypointCount;i++)
	{
		if(!isDefined(level.waypoints[i].childCount) || level.waypoints[i].childCount <= 1)
		{
			iPrintLnBold("Waypoint: " + i + " has no children!");
			level.missingLinks[level.missingLinks.size] = level.waypoints[i];
		}
	}
	
	iPrintLnBold(level.waypointCount + " Waypoints processed.");
}

jumpToUnlinkedWaypoints()
{
	if(!isDefined(level.missingLinks) || !level.missingLinks.size)
		return;
	
	self setOrigin(level.missingLinks[self.currentCheck].origin);
	self.currentCheck++;
			
	if(self.currentCheck >= level.missingLinks.size)
		self.currentCheck = 0;
}