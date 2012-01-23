package com.pixelrebellen.sushiman.game.models
{
	import com.pixelrebellen.sushiman.game.config.GameConfig;
	/**
	 * @author JESSA
	 */
	public class GameModel
	{
		public var level:int;
		
		public var lifes:int;
		
		public var score:int;
		
		public var levelEnemiesCountCollection : Array;
		
		
		public function GameModel()
		{
			reset();
		}
		
		public function reset():void
		{
			lifes = GameConfig.HERO_LIFES;
			score = 0;
			
			level = -1;
			
			levelEnemiesCountCollection = [];
			
			for(var i:int = 0; i < GameConfig.LEVEL_ENEMIES_COUNT_COLLECTION.length; i++)
			{
				levelEnemiesCountCollection.push(GameConfig.LEVEL_ENEMIES_COUNT_COLLECTION[i]);
			}
		}

		public function get enemies() : int
		{
			if(level < -1) return -1;
			return levelEnemiesCountCollection[level-1];
		}
		
		public function set enemies(value:int) : void
		{
			if(level < -1) return;
			levelEnemiesCountCollection[level-1] = value;
		}
		
	}
}
