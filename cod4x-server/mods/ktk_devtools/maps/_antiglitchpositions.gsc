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

initBlockers()
{
	switch(getDvar("mapname")) 
	{
		case "mp_fav":
			level.blockers[0] = spawn("trigger_radius", (1580, -1070, 300),0, 100, 15);
			level.blockers[1] = spawn("trigger_radius", (1912, 171, 161),0, 18, 110);
			break;
		case "mp_c4s_minecraft":
			level.blockers[0] = spawn("trigger_radius", (541.108, -2244.38, 36.125),0, 10, 52);
			level.blockers[1] = spawn("trigger_radius", (-1447.88, -762.625, -35.875),0, 10, 105.026);
			break;
	
		//---------------------------------------------------------------------
		//	Add your maps after this
		//---------------------------------------------------------------------
		
		//---------------------------------------------------------------------
		//	Add your maps before this
		//---------------------------------------------------------------------
	
		default: return undefined;
	}
	
	return level.blockers;
}

initGlitchtriggers()
{
	switch(getDvar("mapname")) 
	{
		case "mp_beta":
			level.glitchtriggers[0] = spawn("trigger_radius", (-2038, -39, -1),0, 45, 444);
			break;
	
		case "mp_backlot":
			level.glitchtriggers[0] = spawn("trigger_radius", (638, -1040, 318), 0, 60, 200);
			level.glitchtriggers[1] = spawn("trigger_radius", (3, -817, 312), 0, 60, 30);
			level.glitchtriggers[2] = spawn("trigger_radius", (1031, -1450, 342), 0, 400, 200);
			level.glitchtriggers[3] = spawn("trigger_radius", (1545, 526, 281), 0, 20, 120);
			level.glitchtriggers[4] = spawn("trigger_radius", (335, 237, 277), 0, 4, 120);
			level.glitchtriggers[5] = spawn("trigger_radius", (262, 231, 277), 0, 4, 120);
			level.glitchtriggers[6] = spawn("trigger_radius", (181, 1401, 212), 0, 3, 120);
			level.glitchtriggers[7] = spawn("trigger_radius", (-343, -1428, 207), 0, 5, 120);
			level.glitchtriggers[8] = spawn("trigger_radius", (-343, -1266, 207), 0, 5, 120);
			level.glitchtriggers[9] = spawn("trigger_radius", (-776, -961, 246), 0, 30, 120);
			level.glitchtriggers[10] = spawn("trigger_radius", (479, -1060, 260), 0, 60, 120);
			level.glitchtriggers[11] = spawn("trigger_radius", (495, -1073, 211), 0, 80, 120);
			level.glitchtriggers[12] = spawn("trigger_radius", (344, 1415, 277), 0, 5, 120);
			level.glitchtriggers[13] = spawn("trigger_radius", (1350, 245, 293), 0, 30, 120);
			level.glitchtriggers[14] = spawn("trigger_radius", (1585, 986, 198),0, 50, 200);
			level.glitchtriggers[15] = spawn("trigger_radius", (1510, 990, 198),0, 50, 200);
			level.glitchtriggers[16] = spawn("trigger_radius", (500, 1392, 260),0, 15, 100);
			level.glitchtriggers[17] = spawn("trigger_radius", (1793, -143, 450),0, 15, 100);
			level.glitchtriggers[18] = spawn("trigger_radius", (741, -1648, 2200),0, 15, 100);
			break;
		
		case "mp_bloc":
			level.glitchtriggers[0] = spawn("trigger_radius", (-1162, -4432, 105), 0, 30, 400);
			level.glitchtriggers[1] = spawn("trigger_radius", (-521, -6157, 105), 0, 30, 400); 
			level.glitchtriggers[2] = spawn("trigger_radius", (2728, -5493, 105), 0, 30, 400); 
			level.glitchtriggers[3] = spawn("trigger_radius", (-596, -6207, 1000), 0, 30, 200);
			level.glitchtriggers[4] = spawn("trigger_radius", (-1215, -4354, 1000), 0, 30, 200);
			level.glitchtriggers[5] = spawn("trigger_radius", (2439, -5295, 1000), 0, 30, 200);
			level.glitchtriggers[6] = spawn("trigger_radius", (3423, -7241, 1000), 0, 30, 200);
			level.glitchtriggers[7] = spawn("trigger_radius", (-39, -4622, 450), 0, 30, 200);
			level.glitchtriggers[8] = spawn("trigger_radius", (2751, -5441, 1000), 0, 30, 200);
			break;
			
		case "mp_cargoship":
			level.glitchtriggers[0] = spawn("trigger_radius", (-2997, -233, 355), 0, 30, 400); 
			level.glitchtriggers[1] = spawn("trigger_radius", (-2985, 234, 355), 0, 30, 400); 
			level.glitchtriggers[2] = spawn("trigger_radius", (957, 194, 335), 0, 20, 400); 
			level.glitchtriggers[3] = spawn("trigger_radius", (-620, -190, 335), 0, 20, 400);
			level.glitchtriggers[4] = spawn("trigger_radius", (980, -205, 335), 0, 20, 400); 
			level.glitchtriggers[5] = spawn("trigger_radius", (-613, 191, 335), 0, 20, 400); 
			break;
			
		case "mp_convoy":
			level.glitchtriggers[0] = spawn("trigger_radius", (790, 1203, 86), 0, 50, 400); 
			level.glitchtriggers[1] = spawn("trigger_radius", (1154, 392, 104), 0, 40, 400); 
			level.glitchtriggers[2] = spawn("trigger_radius", (-447, 177, 118), 0, 50, 400); 
			level.glitchtriggers[3] = spawn("trigger_radius", (-1078, 233, 121), 0, 50, 400); 
			level.glitchtriggers[4] = spawn("trigger_radius", (-843, 1198, 203), 0, 30, 400);
			level.glitchtriggers[5] = spawn("trigger_radius", (647, 448, 146), 0, 10, 50);
			level.glitchtriggers[6] = spawn("trigger_radius", (1094, -876, 100), 0, 50, 100);
			level.glitchtriggers[7] = spawn("trigger_radius", (2729, -526, 72), 0, 50, 100);
			level.glitchtriggers[8] = spawn("trigger_radius", (752, 1044, 32),0, 120, 200);
			break;
			
		case "mp_countdown":
			level.glitchtriggers[0] = spawn("trigger_radius", (2192, 453, 500), 0, 30, 200);
			level.glitchtriggers[1] = spawn("trigger_radius", (1910, 987, 500), 0, 30, 200);
			level.glitchtriggers[2] = spawn("trigger_radius", (-2230, 511, 450), 0, 30, 200);
			level.glitchtriggers[3] = spawn("trigger_radius", (-2092, 1352, 450), 0, 30, 200);
			break;
			
		case "mp_crash":
		case "mp_crash_snow":
			level.glitchtriggers[0] = spawn("trigger_radius", (1793, 1084, 590), 0, 30, 400);
			level.glitchtriggers[1] = spawn("trigger_radius", (1301, 167, 488), 0, 40, 400);	
			level.glitchtriggers[2] = spawn("trigger_radius", (654, -855, 392), 0, 20, 92);	
			level.glitchtriggers[3] = spawn("trigger_radius", (666, -838, 441), 0, 20, 92);	
			level.glitchtriggers[4] = spawn("trigger_radius", (179, -780, 448), 0, 50, 92); 	
			level.glitchtriggers[5] = spawn("trigger_radius", (685, -746, 437), 0, 50, 92); 
			level.glitchtriggers[6] = spawn("trigger_radius", (1370, -1343, 350), 0, 22, 120);
			level.glitchtriggers[7] = spawn("trigger_radius", (-339, 898, 383), 0, 50, 200);
			level.glitchtriggers[8] = spawn("trigger_radius", (-339, 898, 383), 0, 50, 200);
			level.glitchtriggers[9] = spawn("trigger_radius", (-339, 963, 383), 0, 50, 200);
			level.glitchtriggers[10] = spawn("trigger_radius", (-339, 1028, 383), 0, 50, 200);
			level.glitchtriggers[11] = spawn("trigger_radius", (1180, 1424, 411), 0, 100, 400);
			level.glitchtriggers[12] = spawn("trigger_radius", (1072, 1341, 2100), 0, 30, 100);
			level.glitchtriggers[13] = spawn("trigger_radius", (1687, 650, 700), 0, 10, 50);
			level.glitchtriggers[14] = spawn("trigger_radius", (225, 550, 450), 0, 50, 100);
			level.glitchtriggers[15] = spawn("trigger_radius", (-17.0276, -1015.46, 370.125),0, 47, 100);			
			break;
			
		case "mp_farm":
			level.glitchtriggers[0] = spawn("trigger_radius", (-904, -1092, 300), 0, 30, 400); 
			break;
			
		case "mp_overgrown":
			level.glitchtriggers[0] = spawn("trigger_radius", (-734, -5175, -19), 0, 300, 400); 
			level.glitchtriggers[1] = spawn("trigger_radius", (-1923, -4488, 10), 0, 370, 400);
			level.glitchtriggers[2] = spawn("trigger_radius", (-1630, -3502, 55), 0, 30, 50);
			level.glitchtriggers[3] = spawn("trigger_radius", (-1863, -3985, 55), 0, 30, 50);
			break;
			
		case "mp_pipeline":
			level.glitchtriggers[0] = spawn("trigger_radius", (616, 1419, -86), 0, 20, 60);
			level.glitchtriggers[1] = spawn("trigger_radius", (616, 1471, -86), 0, 20, 60);
			level.glitchtriggers[2] = spawn("trigger_radius", (616, 1513, -86), 0, 20, 60);
			level.glitchtriggers[3] = spawn("trigger_radius", (616, 1546, -86), 0, 20, 60);
			level.glitchtriggers[4] = spawn("trigger_radius", (616, 1582, -86), 0, 20, 60);
			level.glitchtriggers[5] = spawn("trigger_radius", (616, 1624, -86), 0, 20, 60);
			level.glitchtriggers[6] = spawn("trigger_radius", (616, 1661, -86), 0, 20, 60); 
			level.glitchtriggers[7] = spawn("trigger_radius", (616, 1661, -86), 0, 20, 60); 
			level.glitchtriggers[8] = spawn("trigger_radius", (616, 1691, -86), 0, 20, 60); 
			level.glitchtriggers[9] = spawn("trigger_radius", (616, 1721, -86), 0, 20, 60); 
			level.glitchtriggers[10] = spawn("trigger_radius", (616, 1792, -86), 0, 20, 60); 
			level.glitchtriggers[11] = spawn("trigger_radius", (616, 1830, -86), 0, 20, 60); 
			level.glitchtriggers[12] = spawn("trigger_radius", (616, 1869, -86), 0, 20, 60); 
			level.glitchtriggers[13] = spawn("trigger_radius", (616, 1899, -86), 0, 20, 60); 
			level.glitchtriggers[14] = spawn("trigger_radius", (616, 1932, -86), 0, 20, 60); 
			level.glitchtriggers[15] = spawn("trigger_radius", (616, 1973, -86), 0, 20, 60); 
			level.glitchtriggers[16] = spawn("trigger_radius", (616, 2007, -86), 0, 20, 60); 
			level.glitchtriggers[17] = spawn("trigger_radius", (616, 2050, -86), 0, 20, 60); 
			level.glitchtriggers[18] = spawn("trigger_radius", (616, 2104, -86), 0, 20, 60);
			level.glitchtriggers[19] = spawn("trigger_radius", (1329, 573, 450), 0, 30, 60);
			level.glitchtriggers[20] = spawn("trigger_radius", (-168, 872, 350),0, 210, 200);
			level.glitchtriggers[21] = spawn("trigger_radius", (-156, 1150, 350),0, 191, 200);
			break;
			
		case "mp_showdown":
			level.glitchtriggers[0] = spawn("trigger_radius", (-3, 72, 340), 0, 5000, 1000);
			break;
			
		case "mp_strike":
			level.glitchtriggers[0] = spawn("trigger_radius", (-2313, 917, 174), 0, 30, 400);
			level.glitchtriggers[1] = spawn("trigger_radius", (-2313, 723, 174), 0, 30, 400);
			level.glitchtriggers[2] = spawn("trigger_radius", (685, 852, 305), 0, 60, 400);
			level.glitchtriggers[3] = spawn("trigger_radius", (758, -73, 166), 0, 30, 400);
			level.glitchtriggers[4] = spawn("trigger_radius", (234, 1137, 166), 0, 10, 400);
			level.glitchtriggers[5] = spawn("trigger_radius", (94, 1137, 166), 0, 10, 400);
			level.glitchtriggers[6] = spawn("trigger_radius", (361, 633, 220), 0, 54, 300);
			level.glitchtriggers[7] = spawn("trigger_radius", (358, 550, 220), 0, 53, 300);
			level.glitchtriggers[8] = spawn("trigger_radius", (360, 503, 220), 0, 60, 300);
			level.glitchtriggers[9] = spawn("trigger_radius", (911, 286, 238), 0, 100, 400);
			level.glitchtriggers[10] = spawn("trigger_radius", (911, 152, 238), 0, 100, 400);
			level.glitchtriggers[11] = spawn("trigger_radius", (1904, 1400, 308), 0, 100, 400);
			level.glitchtriggers[12] = spawn("trigger_radius", (-360, 1243, 223),0, 50, 150);
			level.glitchtriggers[13] = spawn("trigger_radius", (-357, 1308, 223), 0, 50, 150);
			level.glitchtriggers[14] = spawn("trigger_radius", (-360, 1373, 223), 0, 50, 150);
			level.glitchtriggers[15] = spawn("trigger_radius", (-425, 1249, 223), 0, 50, 150);
			level.glitchtriggers[16] = spawn("trigger_radius", (-490, 1252, 223), 0, 50, 150);
			level.glitchtriggers[17] = spawn("trigger_radius", (-555, 1250, 223), 0, 50, 150);
			level.glitchtriggers[18] = spawn("trigger_radius", (-620, 1255, 223), 0, 50, 150);
			level.glitchtriggers[19] = spawn("trigger_radius", (-685, 1257, 223), 0, 50, 150);
			level.glitchtriggers[20] = spawn("trigger_radius", (-750, 1256, 223), 0, 50, 150);
			level.glitchtriggers[21] = spawn("trigger_radius", (-815, 1256, 223), 0, 50, 150);
			level.glitchtriggers[22] = spawn("trigger_radius", (-881, 1257, 223), 0, 50, 150);
			level.glitchtriggers[23] = spawn("trigger_radius", (-930, 1249, 223), 0, 50, 150);
			level.glitchtriggers[24] = spawn("trigger_radius", (-924, 1314, 223), 0, 50, 150);
			level.glitchtriggers[25] = spawn("trigger_radius", (-924, 1379, 223), 0, 50, 150);
			level.glitchtriggers[26] = spawn("trigger_radius", (-924, 1444, 223), 0, 50, 150);
			level.glitchtriggers[27] = spawn("trigger_radius", (-1159, 2028, 600), 0, 500, 200);
			level.glitchtriggers[28] = spawn("trigger_radius", (265, 1137, 900), 0, 30, 100);
			level.glitchtriggers[29] = spawn("trigger_radius", (447, -1045, 308),0, 50, 130);
			break;
	
		//---------------------------------------------------------------------
		//	Add your maps after this
		//---------------------------------------------------------------------
		
		//---------------------------------------------------------------------
		//	Add your maps before this
		//---------------------------------------------------------------------
	
		default: return undefined;
	}
	
	return level.glitchtriggers;
}

initGlitchLasers()
{
	switch(getDvar("mapname")) 
	{
		case "mp_4nuketown":
			level.glitchtrace[0] = spawn("script_origin", (-2568, -1464, 203));
			level.glitchtrace[0].end = spawn("script_origin", (-193, -1468, 203));
			level.glitchtrace[1] = level.glitchtrace[0].end;
			level.glitchtrace[1].end = spawn("script_origin", (-109, -1895, 203));
			level.glitchtrace[2] = level.glitchtrace[1].end;
			level.glitchtrace[2].end = spawn("script_origin", (344, -1806, 203));
			level.glitchtrace[3] = level.glitchtrace[2].end;
			level.glitchtrace[3].end = spawn("script_origin", (322, -1685, 203));
			level.glitchtrace[4] = level.glitchtrace[3].end;
			level.glitchtrace[4].end = spawn("script_origin", (777, -1596, 203));
			level.glitchtrace[5] = spawn("script_origin", (777, -1596, 250));
			level.glitchtrace[5].end = spawn("script_origin", (686, -1196, 250));
			level.glitchtrace[6] = spawn("script_origin", (686, -1196, 203));
			level.glitchtrace[6].end = spawn("script_origin", (1235, -969, 203));
			level.glitchtrace[7] = level.glitchtrace[6].end;
			level.glitchtrace[7].end = spawn("script_origin", (1457, -488, 203));
			level.glitchtrace[8] = level.glitchtrace[7].end;
			level.glitchtrace[8].end = spawn("script_origin", (1457, 219, 203));
			level.glitchtrace[9] = level.glitchtrace[8].end;
			level.glitchtrace[9].end = spawn("script_origin", (1457, 219, 203));
			level.glitchtrace[10] = level.glitchtrace[9].end;
			level.glitchtrace[10].end = spawn("script_origin", (1244, 708, 203));
			level.glitchtrace[11] = level.glitchtrace[10].end;
			level.glitchtrace[11].end = spawn("script_origin", (1529, 1052, 203));
			level.glitchtrace[12] = level.glitchtrace[11].end;
			level.glitchtrace[12].end = spawn("script_origin", (1298, 1242, 203));
			level.glitchtrace[13] = level.glitchtrace[12].end;
			level.glitchtrace[13].end = spawn("script_origin", (1410, 1378, 203));
			level.glitchtrace[14] = level.glitchtrace[13].end;
			level.glitchtrace[14].end = spawn("script_origin", (820, 1865, 203));
			level.glitchtrace[15] = level.glitchtrace[14].end;
			level.glitchtrace[15].end = spawn("script_origin", (648, 1656, 203));
			level.glitchtrace[16] = level.glitchtrace[15].end;
			level.glitchtrace[16].end = spawn("script_origin", (-2571, 1656, 203));
			level.glitchtrace[17] = spawn("script_origin", (-2571, 1656, 190));
			level.glitchtrace[17].end = spawn("script_origin", (-2568, -1464, 190));
			break;
		case "mp_beta":
			level.glitchtrace[0] = spawn("script_origin", (-1023, -866, 170));
			level.glitchtrace[0].end = spawn("script_origin", (-1235, -797, 170));
			level.glitchtrace[1] = level.glitchtrace[0].end;
			level.glitchtrace[1].end = spawn("script_origin", (-1470, -747, 170));
			level.glitchtrace[2] = level.glitchtrace[1].end;
			level.glitchtrace[2].end = spawn("script_origin", (-2016, -764, 170));
			level.glitchtrace[3] = level.glitchtrace[2].end;
			level.glitchtrace[3].end = spawn("script_origin", (-1997, -27, 170));
			break;
		case "mp_kabul_moh":
			level.glitchtrace[0] = spawn("script_origin", (2612, 3492, 242));
			level.glitchtrace[0].end = spawn("script_origin", (2612, 2831, 242));
			level.glitchtrace[1] = level.glitchtrace[0].end;
			level.glitchtrace[1].end = spawn("script_origin", (3269, 2825, 242));
			level.glitchtrace[2] = level.glitchtrace[1].end;
			level.glitchtrace[2].end = spawn("script_origin", (3269, 2039, 242));
			level.glitchtrace[3] = level.glitchtrace[2].end;
			level.glitchtrace[3].end = spawn("script_origin", (3901, 2039, 242));
			level.glitchtrace[4] = spawn("script_origin", (2605, 3618, 148));
			level.glitchtrace[4].end = spawn("script_origin", (2239, 3618, 148));
			break;

		//---------------------------------------------------------------------
		//	Add your maps after this
		//---------------------------------------------------------------------
		
		//---------------------------------------------------------------------
		//	Add your maps before this
		//---------------------------------------------------------------------
			
		default: return undefined;
	}
	
	return level.glitchtrace;
}