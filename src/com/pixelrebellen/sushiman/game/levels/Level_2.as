/*
 * Copyright 2011 Netzbewegung GmbH
 * All Rights Reserved.
 * 
 * NOTICE: Netzbewegung GmbH permits you to use, modify, and distribute this 
 * file in accordance with the terms of the license agreement accompanying it.
 *
 * Created by Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com> on 07.03.2011. 
 */
package com.pixelrebellen.sushiman.game.levels
{
	import com.pixelrebellen.sushiman.game.characters.Enemies;
	import com.pixelrebellen.sushiman.game.characters.Hero;
	import com.pixelrebellen.sushiman.game.config.GameConfig;
	import com.pixelrebellen.sushiman.game.items.Items;
	import com.pixelrebellen.sushiman.game.statics.SpawnPlaces;
	import com.pixelrebellen.sushiman.game.tilemaps.TileMapLevel_2;

	import flash.geom.Point;




    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
	 */
	public class Level_2 extends Level_1
    {
        
        public function Level_2()
        {
            super();
        }
        
        override public function create():void
		{
			//add(new LevelBackground());
			
			levelTileMap = new TileMapLevel_2();
			levelTileMap.visible = GameConfig.TILEMAP_VISIBLE;
			add(levelTileMap);
			
			var btW:Number = GameConfig.BASE_TILE_WIDTH;
			var btH:Number = GameConfig.BASE_TILE_HEIGHT;
			
			var spawnPoints:Array = [new Point(btW * 10, btH * 6)];
			
			var spawnPlaces:SpawnPlaces = new SpawnPlaces(spawnPoints);
			add(spawnPlaces);
			
			hero = new Hero(btW * 2, btH * 6);
			add(hero);
			
			hero.restart();
			
			
			items = new Items(levelTileMap.getData(true), [10, 3, 4]);
			add(items);
			
			
			enemies = new Enemies(spawnPoints, GameConfig.LEVEL_ENEMIES_COUNT_COLLECTION[1], 6, 1, hero, levelTileMap);
			add(enemies);
			
			enemies.restart();
			
			
		}
		
    }
}
