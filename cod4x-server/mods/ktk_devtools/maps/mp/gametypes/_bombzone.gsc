init()
{
	wait 5;

	level.ktkWeaponBoxes = [];

	initBombZones();
	replaceBombZoneModels();
}

initBombZones()
{
	entities = getEntArray();
	for(i=0;i<entities.size;i++)
	{
		if(entities[i].classname != "script_model" && entities[i].classname != "script_brushmodel")
			continue;
			
		//not save enough
		//if(entities[i].model != "p_glo_bomb_stack")
		//	continue;
		
		if(!isDefined(entities[i].script_gameobjectname))
			continue;
		
		gameobjectnames = strtok(entities[i].script_gameobjectname, " ");
			
		for(j=0;j<gameobjectnames.size;j++)
		{
			if(gameobjectnames[j] == "bombzone")
			{
				level.ktkWeaponBoxes[level.ktkWeaponBoxes.size] = entities[i];
				break;
			}
		}
	}
}

replaceBombZoneModels()
{
	modelInfo = [];

	for(i=0;i<level.ktkWeaponBoxes.size;i++)
	{
		// delete existing bombzone models
		if(level.ktkWeaponBoxes[i].classname == "script_model")
		{
			curEntry = modelInfo.size;
			modelInfo[curEntry] = spawnStruct();
			modelInfo[curEntry].origin = level.ktkWeaponBoxes[i].origin;
			modelInfo[curEntry].angles = level.ktkWeaponBoxes[i].angles;
			modelInfo[curEntry].model = level.ktkWeaponBoxes[i].model;
			
			level.ktkWeaponBoxes[i] delete();
			continue;
		}
		
		// delete bombzone clips
		if(level.ktkWeaponBoxes[i].classname == "script_brushmodel")
		{
			level.ktkWeaponBoxes[i] delete();
			continue;
		}
	}

	// spawn new bombzone models and make them solid
	for(i=0;i<modelInfo.size;i++)
	{
		trace = bulletTrace(modelInfo[i].origin+(0,0,10), modelInfo[i].origin+(0,0,-10000), false, undefined);
		spawnpoint = trace["position"];

		newBombSpotModel = spawn("script_model", spawnpoint);
		newBombSpotModel setModel("com_bomb_objective_obj");
		newBombSpotModel.angles = modelInfo[i].angles;
		
		//solid = spawn("trigger_radius", spawnpoint, 0, 50, 80);
		//solid setContents(1);
	}
}