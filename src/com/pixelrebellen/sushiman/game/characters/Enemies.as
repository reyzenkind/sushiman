package com.pixelrebellen.sushiman.game.characters
{
	import com.pixelrebellen.core.math.Random;
	import com.pixelrebellen.sushiman.game.config.GameConfig;
	import flash.geom.Point;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxTimer;



	/**
	 * @author JESSA
	 */
	public class Enemies extends FlxGroup
	{
		private var respawns:Array;
		
		private var numOfEnemies:int;
		private var numOfVisible:int;
		private var numOfHunters:int;
		
		private var huntTarget : FlxSprite;
		private var hunterMap : FlxTilemap;
		
		private var countHunters:int = 0;
		private var countEnemies:int = 0;
		
		
		private var timer : FlxTimer;
		private var huntTimer : FlxTimer;
		
		private var _areHunted : Boolean;
		
		
		public function Enemies(respawns:Array, numOfEnemies:int, numOfVisible:int, numOfHunters:int, huntTarget:FlxSprite, hunterMap:FlxTilemap, maxSize : uint = 0)
		{
			super(maxSize);
			
			
			this.respawns = respawns;
			
			this.numOfEnemies = numOfEnemies;
			this.numOfVisible = numOfVisible;
			this.numOfHunters = numOfHunters;
			
			this.huntTarget = huntTarget;
			this.hunterMap = hunterMap;
			
			
			//trace("-----");
			
		}
		
		
		
		public function respawn():void
		{
			if(timer != null)
			{
				timer.destroy();
			}
			
			
			timer = new FlxTimer();
			timer.start(GameConfig.RESPAWN_TIME, 0 , respawnOnTimer);
		}
		
		
		private function respawnOnTimer(sTimer:FlxTimer):void
		{
    		sTimer.destroy();
			
			//trace(countEnemies, numOfEnemies, numOfVisible, countEnemies < numOfEnemies, countEnemies < numOfVisible);
			
			if(countEnemies < numOfEnemies && countEnemies < numOfVisible)
			{
				var enemy:Enemy = new Enemy();
				add(enemy);
				
				var spawnPoint:Point = Point(respawns[Random.rInt(0, respawns.length)]);
				
				enemy.x = spawnPoint.x;
				enemy.y = spawnPoint.y;
				
				enemy.isHunted = _areHunted;
				
				
				if(countHunters < numOfHunters)
				{
					countHunters++;
					enemy.huntFor(huntTarget, hunterMap);
				}
				else
				{
					enemy.freeWalk(hunterMap);
				}
				
				countEnemies++;
				
				respawn();
			}
		}

		public function get areHunted() : Boolean
		{
			return _areHunted;
		}

		public function set areHunted(value : Boolean) : void
		{
			_areHunted = value;
			
			setAll('isHunted', _areHunted);
			
			if(huntTimer != null)
			{
				huntTimer.destroy();
			}
			
			huntTimer = new FlxTimer();
			huntTimer.start(GameConfig.HUNT_TIME, 0, onHuntComplete);
		}
		
		private function onHuntComplete(pHuntTimer:FlxTimer):void
		{
			pHuntTimer.destroy();
			
			_areHunted = false;
			setAll('isHunted', _areHunted);
		}

		public function killEnemy(enemy : Enemy) : void
		{
			if(enemy.type == 0)
			{
				countHunters--;
			}
			
			enemy.kill();
			countEnemies--;
			numOfEnemies--;
		}

		public function restart() : void
		{
			countHunters = 0;
			countEnemies = 0;
			
			members = [];
			
			respawn();
		}
		
	}
}
