/*--------------------------------------------------------------------------|
|							DevTool to place ladders						|
|--------------------------------------------------------------------------*/
ExportLadders()
{
	if(level.laddermodel.size > 0)
	{
		setdvar("logfile", 2);
		
		println("\n\n\n");
		println("//Ladders");
		println("	case \""+getdvar("mapname")+"\":");
	
		for(i=0;i<level.laddermodel.size;i++)
		{
			if(!isDefined(level.laddermodel[i].ground) || !isDefined(level.laddermodel[i].elevation) || !isDefined(level.laddermodel[i].dist))
			{
				iPrintLnBold("The climbpath of a ladder is not defined!");
				return 0;
			}
		
			if(isDefined(level.laddermodel[i].origin) && isDefined(level.laddermodel[i].angles) && isDefined(level.laddermodel[i].ground) && isDefined(level.laddermodel[i].elevation) && isDefined(level.laddermodel[i].dist))
			{
				PrintLn("spawnLadderTrigger(" + i + ", " + level.laddermodel[i].ground + ", " + level.laddermodel[i].angles[1] + ", " + level.laddermodel[i].dist + ", " + level.laddermodel[i].elevation + ", 25, 20);");
				PrintLn("spawnLadderModel(" + level.laddermodel[i].origin + ", " + level.laddermodel[i].angles + ");");
			}
		}
		
		println("	break;");
		println("\n\n\n");

		setdvar("logfile", 0);
		iPrintLn("New ladders saved to the log.");
		return 1;
	}
	
	iPrintLnBold("Nothing to export yet!");
	return 0;
}

/*--------------------------------------------------------------------------|
|						DevTool for Antiglitch Blockers						|
|--------------------------------------------------------------------------*/
saveBlockers()
{
	setdvar("logfile", 2);
	println("\n\n\n");
	
	if(!isDefined(level.triggers) || level.triggers.size == 0)
	{
		iPrintLnBold("Nothing to export yet!");
		return 0;
	}
	
	name = "";
	if(getDvar("scr_devtool_edit") == "triggers")
	{
		name = "level.glitchtriggers";
		println("//Antiglitch-Triggers");
	}
	else
	{
		name = "level.blockers";
		println("//Antiglitch-Blockers");
	}

	if(!isDefined(name) || name == "")
	{
		iPrintLnBold("Dvar 'scr_devtool_edit' is empty - Please restart the game!");
		return 0;
	}
	
	println("	case \""+getdvar("mapname")+"\":");
	
	for(i=0;i<level.triggers.size;i++)
	{
		trigger = level.triggers[i];
		println("		" + name + "["+i+"] = spawn(\"trigger_radius\", "+trigger.origin+",0, "+trigger.radius+", "+trigger.height+");");
	}
	
	println("	break;");
	println("\n\n\n");
	
	setdvar("logfile", 0);
	
	iPrintLn("Blockers saved to console log!");
	return 1;
}

/*--------------------------------------------------------------------------|
|							Laser Detector Lines							|
|--------------------------------------------------------------------------*/
ExportLasers()
{
	if(level.glitchtrace.size > 0)
	{
		setdvar("logfile", 2);
		
		println("\n\n\n");
		println("//Antiglitch-Lasers");
		println("	case \""+getdvar("mapname")+"\":");
	
		for(i=0;i<level.glitchtrace.size;i++)
		{
			if(isDefined(level.glitchtrace[i].origin) && isDefined(level.glitchtrace[i].end.origin))
			{
				PrintLn("	level.glitchtrace["+i+"] = spawn(\"script_origin\", " + level.glitchtrace[i].origin +  ");");
				PrintLn("	level.glitchtrace["+i+"].end = spawn(\"script_origin\", " + level.glitchtrace[i].end.origin +  ");");
			}
		}
		
		println("	break;");
		println("\n\n\n");
		
		setdvar("logfile", 0);
		iPrintLn("Lasers saved to the log.");
		return 1;
	}
	
	iPrintLnBold("Nothing to export yet!");
	return 0;
}

/*--------------------------------------------------------------------------|
|					DevTool to setup the waypoints for bots					|
|--------------------------------------------------------------------------*/
SaveStaticWaypoints()
{
 	if(!isDefined(level.waypoints) || level.waypoints.size == 0)
	{
		iPrintLnBold("Nothing to export yet!");
		return 0;
	}

	if((gettime()-level.saveSpamTimer) < 1500)
		return 0;

	level.saveSpamTimer = gettime();
	setDvar("logfile", 1);

	mapname = tolower(getDvar("mapname"));
	filename = mapname + "_waypoints.gsc";

	info = [];
	info[0] = "// =========================================================================================";
	info[1] = "// File Name = '" + filename + "'";
	info[2] = "// Map Name  = '" + mapname + "'";
	info[3] = "// =========================================================================================";
	info[4] = "// ";
	info[5] = "// This is an auto generated script file created by the PeZBOT Mod - DO NOT MODIFY!";
	info[6] = "// ";
	info[7] = "// =========================================================================================";
	info[8] = "// ";
	info[9] = "// This file contains the waypoints for the map '" + mapname + "'.";	
	info[10] = "// ";
	info[11] = "// You now need to save this file as the file name at the top of this file.";
	info[12] = "// in the 'waypoint.iwd' file in a folder called the same as the map name.";
	info[13] = "// Delete the first two lines of this file and the 'Dvar set logfile 0' at the end of the file.";
	info[14] = "// Create the new folder if you havent already done so and rename it to the map name.";
	info[15] = "// So - new_waypoints.iwd/" + filename;
	info[16] = "// ";
	info[17] = "// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.";
	info[18] = "// just follow the instructions at the top of the file. you will need to add the following code.";
	info[19] = "// I couldnt output double quotes to file so replace the single quotes with double quotes.";
	info[20] = "// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.";
	info[21] = "/*";
	info[22] = " ";
	info[23] = "    else if(mapname == '"+ mapname +"')";
	info[24] = "    {";
	info[25] = "        thread Waypoints/" + mapname + "_waypoints::load_waypoints();";
	info[26] = "    }";
	info[27] = " ";
	info[28] = "*/ ";
	info[29] = "// =========================================================================================";
	info[30] = " ";	
	
	for(i = 0; i < info.size; i++)
		println(info[i]);
	
	scriptstart = [];
	scriptstart[0] = "load_waypoints()";
	scriptstart[1] = "{";
	
	for(i = 0; i < scriptstart.size; i++)
		println(scriptstart[i]);

	for(w=0;w<level.waypoints.size;w++)
	{
		waypointstruct = "    level.waypoints[" + w + "] = spawnstruct();";
		println(waypointstruct);
	
		waypointstring = "    level.waypoints[" + w + "].origin = "+ "(" + level.waypoints[w].origin[0] + "," + level.waypoints[w].origin[1] + "," + level.waypoints[w].origin[2] + ");";
		println(waypointstring);

		waypointtype = "    level.waypoints[" + w + "].type = " + "\"" + level.waypoints[w].type + "\"" + ";";
		println(waypointtype);
		
		waypointchild = "    level.waypoints[" + w + "].childCount = " + level.waypoints[w].childCount + ";";
		println(waypointchild);

		for(c=0;c<level.waypoints[w].childCount;c++)
		{
			childstring = "    level.waypoints[" + w + "].children[" + c + "] = " + level.waypoints[w].children[c] + ";";
			println(childstring);      
		}
		
		if(level.waypoints[w].type == "climb" || level.waypoints[w].type == "mantle" || level.waypoints[w].type == "jump" || level.waypoints[w].type == "plant")
		{
		    waypointangle = "    level.waypoints[" + w + "].angles = " + level.waypoints[w].angles + ";";
			println(waypointangle);
		}
		
		if(level.waypoints[w].type == "climb" || level.waypoints[w].type == "mantle" || level.waypoints[w].type == "plant")
		{
			waypointusestate = "    level.waypoints[" + w + "].use = true;";
			println(waypointusestate);
		}
	}
	
	scriptmiddle = [];
	scriptmiddle[0] = " ";
	scriptmiddle[1] = "    level.waypointCount = level.waypoints.size;";
	scriptmiddle[2] = " ";
	
	for(i=0;i<scriptmiddle.size;i++)
		println(scriptmiddle[i]);
	
	scriptend = [];
	scriptend[0] = "}";
	
	for(i = 0; i < scriptend.size; i++)
		println(scriptend[i]);

	setDvar("logfile", 0);

	iprintlnBold("^0Waypoints Outputted To Console Log In Mod Folder");
	return 1;
}