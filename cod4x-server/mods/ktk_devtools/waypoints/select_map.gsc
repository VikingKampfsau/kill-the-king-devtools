// =========================================================================================
// Custom waypoint system for PeZBOT by - [WJF] AbneyPark
// www.before-dawn.co.uk
// =========================================================================================
//
// If you have opened this file I expect you want to add a if statement to allow the mod 
// load waypoints for a map that you have just added them to.
// 
// ====================================== INSTRUCTIONS =====================================
//
// Just simply add the generated script section to the end of this file in the marked sections.
//
// I couldn't output double quotes to file so replace the single quotes with double quotes so ' = " 
// I also couldnt output a \ between the mapnames to file, so replace the / with \ in the file names
// it's real easy, use the already added ones as a guide.
//
// DO NOT MODIFY THE REST OF THE FILE
//
// =========================================================================================
 
choose()
{
	mapname = getdvar("mapname");	
	
	level.waypointCount = 0;
	level.waypoints = [];


	if(mapname == "mp_toujane_beta")
        thread waypoints\mp_toujane_beta_waypoints::load_waypoints();
    else
		iprintlnBold("^1[PeZBOT ERROR] ^7- Map " + mapname + " does not support PezBOT waypoints");
}