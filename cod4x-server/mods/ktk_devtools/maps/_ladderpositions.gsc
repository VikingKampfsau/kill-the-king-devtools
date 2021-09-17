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
#include maps\mp\gametypes\_devtools;

initLadders()
{
	switch(getDvar("mapname")) 
	{
		case "lolzor":
			spawnLadderTrigger(0, (-275.515, 319.141, -495.875), 89.3463, 30, 300, 25, 20);
			spawnLadderModel((-274.173, 304.125, -400.426), (0, 89.3463, 180));
			spawnLadderModel((-274.173, 304.125, -600.426), (0, 89.3463, 180));
			
			spawnLadderTrigger(1, (-31.1251, 355.352, -495.875), 181.274, 30, 300, 25, 20);
			spawnLadderModel((-16.125, 356.917, -399.919), (0, 181.274, 180));
			spawnLadderModel((-16.125, 356.917, -599.919), (0, 181.274, 180));
			
			spawnLadderTrigger(2, (-68.2838, 600.875, -495.875), 270.385, 30, 300, 25, 20);
			spawnLadderModel((-68.5629, 615.875, -400.497), (0, 270.385, 180));
			spawnLadderModel((-68.5629, 615.875, -600.497), (0, 270.385, 180));
			
			spawnLadderTrigger(3, (-312.875, 573.363, -475.875), 0.346069, 30, 280, 25, 20);
			spawnLadderModel((-327.875, 572.948, -400.18), (0, 0.346069, 180));
			spawnLadderModel((-327.875, 572.948, -600.18), (0, 0.346069, 180));
			break;
	
		//---------------------------------------------------------------------
		//	Add your maps after this
		//---------------------------------------------------------------------
		
		//---------------------------------------------------------------------
		//	Add your maps before this
		//---------------------------------------------------------------------
	
		default: break;
	}
}