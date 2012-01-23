/*
 * Copyright 2011 Netzbewegung GmbH
 * All Rights Reserved.
 * 
 * NOTICE: Netzbewegung GmbH permits you to use, modify, and distribute this 
 * file in accordance with the terms of the license agreement accompanying it.
 *
 * Created by Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com> on 15.03.2011. 
 */
package com.pixelrebellen.sushiman.game.config
{
	import com.pixelrebellen.sushiman.game.levels.Level_1;
    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
     */
    public class GameConfig
    {
		public static const BASE_MAP_WIDTH:int = 19;
		public static const BASE_MAP_HEIGHT:int = 13;
		
		public static const BASE_TILE_WIDTH:int = 45;
		public static const BASE_TILE_HEIGHT:int = 45;
		
		public static const HERO_VELOCITY_X:int = 200;   	
		public static const HERO_VELOCITY_Y:int = 200;   	
		
		public static const ENEMY_VELOCITY_X:int = 101;   	
		public static const ENEMY_VELOCITY_Y:int = 101; 
		
		//only test;
        public static const START_LEVEL_CLASS : Class = Level_1;
        public static const TILEMAP_VISIBLE : Boolean = true;
		
        public static const RESPAWN_TIME : Number = 2;
        public static const HUNT_TIME : Number = 8;
        
        public static const NORMAL_ITEM_SCORE : int = 10;
        public static const BONUS_ITEM_SCORE : int = 50;
        public static const KILL_ITEM_SCORE : int = 50;
        public static const LIFE_ITEM_SCORE : int = 50;
		
		public static const LEVEL_SCORE : int = 1000;
        
        public static const DEFAULT_VOLUME : Number = 2;
		
		public static const LEVEL_ENEMIES_COUNT_COLLECTION:Array = [10, 15, 20];
		
		public static const HERO_LIFES:int = 3;
        
    }
}
