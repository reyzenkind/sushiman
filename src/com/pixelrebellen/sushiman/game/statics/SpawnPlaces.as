package com.pixelrebellen.sushiman.game.statics
{
	import org.flixel.FlxGroup;

	import flash.geom.Point;

	/**
	 * @author JESSA
	 */
	public class SpawnPlaces extends FlxGroup
	{
		public function SpawnPlaces(spawnPoints:Array, MaxSize : uint = 0)
		{
			super(MaxSize);
			
			var spawnPlace:SpawnPlace;
			
			for(var i:int = 0; i < spawnPoints.length; i++)
			{
				spawnPlace =  new SpawnPlace();
				add(spawnPlace);
				
				spawnPlace.x = Point(spawnPoints[i]).x;
				spawnPlace.y = Point(spawnPoints[i]).y;
			}
		}
	}
}
