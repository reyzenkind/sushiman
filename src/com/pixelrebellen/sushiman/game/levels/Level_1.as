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
	import com.pixelrebellen.sushiman.game.characters.Enemy;
	import com.pixelrebellen.sushiman.game.characters.Hero;
	import com.pixelrebellen.sushiman.game.config.GameConfig;
	import com.pixelrebellen.sushiman.game.events.GameEvent;
	import com.pixelrebellen.sushiman.game.items.ICollectable;
	import com.pixelrebellen.sushiman.game.items.Items;
	import com.pixelrebellen.sushiman.game.items.KillItem;
	import com.pixelrebellen.sushiman.game.statics.LevelBackground;
	import com.pixelrebellen.sushiman.game.statics.SpawnPlaces;
	import com.pixelrebellen.sushiman.game.tilemaps.TileMapLevel_1;

	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;

	import flash.geom.Point;


    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
     */
    public class Level_1 extends FlxState
    {
		protected var levelTileMap:FlxTilemap;
        
        protected var hero:Hero;
		
		protected var enemies:Enemies;
		
		protected var items:Items;
		
		protected var game : FlxGame = FlxG.game;
		
		protected var allowCollisionsWithEnemy : Boolean;
		
        public function Level_1()
        {
            super();
			
			allowCollisionsWithEnemy = true;
        }
        
        override public function create():void
		{
			add(new LevelBackground());
			
			levelTileMap = new TileMapLevel_1();
			levelTileMap.visible = GameConfig.TILEMAP_VISIBLE;
			add(levelTileMap);
			
			var btW:Number = GameConfig.BASE_TILE_WIDTH;
			var btH:Number = GameConfig.BASE_TILE_HEIGHT;
			
			
			var spawnPoints:Array = [new Point(btW * 9, btH * 6)];
			
			var spawnPlaces:SpawnPlaces = new SpawnPlaces(spawnPoints);
			add(spawnPlaces);
			
			
			
			hero = new Hero(btW * 2, btH * 6);
			add(hero);
			
			hero.restart();
			
			
			items = new Items(levelTileMap.getData(true), [10, 3, 4]);
			add(items);
			
			
			enemies = new Enemies(spawnPoints, GameConfig.LEVEL_ENEMIES_COUNT_COLLECTION[0], 4, 1, hero, levelTileMap);
			add(enemies);
			
			enemies.restart();
			
			
		}
		
		override public function update():void
		{
			FlxG.overlap(hero, enemies, onMeetEnemies);
			
			super.update();
			
			FlxG.overlap(hero, items, onCollectItem);
			FlxG.collide(hero, levelTileMap);
			
			
			allowCollisionsWithEnemy = true;
        }
		
		private function onMeetEnemies(hero:FlxSprite, enmy:FlxSprite):void
		{
			var enemy:Enemy = Enemy(enmy);
			
			var a2:Number = ((hero.x + hero.width/2) - (enemy.x + enemy.width/2)) * ((hero.x + hero.width/2) - (enemy.x + enemy.width/2));
        	var b2:Number = ((hero.y + hero.height/2) - (enemy.y + enemy.height/2)) * ((hero.y + hero.height/2) - (enemy.y + enemy.height/2));
        	
			var killCondition:Boolean = a2 + b2 < 20*20;//45*45;
        	
        	if(!killCondition || !allowCollisionsWithEnemy)
        	{
				return;
			}
			
			allowCollisionsWithEnemy = false;
			
			if(enemy.isHunted)
			{
				killEnemy(enemy);
				game.dispatchEvent(new GameEvent(GameEvent.ENEMY_DIED));
			}
			else
			{
				killHero();	
				enemies.restart();
				
				game.dispatchEvent(new GameEvent(GameEvent.HERO_DIED));
			}
			
			
		}

		private function killEnemy(enemy:Enemy) : void
		{
			enemies.killEnemy(enemy);
			enemies.respawn();
		}

		private function killHero() : void
		{
			hero.restart();
		}
			
		private function onCollectItem(hro:FlxSprite, collectedItem:FlxSprite):void
		{
			hro;
			
			//trace(hero, collectedItem);
			var collectableItem:ICollectable;
			
			if(collectedItem is ICollectable)
			{
				collectableItem = ICollectable(collectedItem);
				
				if(collectableItem.type == 1)
				{
					collectedItem.kill();
					game.dispatchEvent(new GameEvent(GameEvent.ITEMS_1_COLLECTED));
				}
				else
				if(collectableItem.type == 2)
				{
					collectedItem.kill();
					game.dispatchEvent(new GameEvent(GameEvent.ITEMS_2_COLLECTED));
				}
				else
				if(collectableItem.type == 3)
				{
					collectedItem.kill();
					game.dispatchEvent(new GameEvent(GameEvent.ITEMS_3_COLLECTED));
				}
				else
				if(collectableItem.type == 4)
				{
					KillItem(collectableItem).kill();
					
					hero.isHunting = true;
					enemies.areHunted = true;
					game.dispatchEvent(new GameEvent(GameEvent.ITEMS_4_COLLECTED));
				}
				
				if(items.countLiving() == 0)
				{
					game.dispatchEvent(new GameEvent(GameEvent.ALL_ITEMS_COLLECTED));
				}
			}
		}
        
    }
}
