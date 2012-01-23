/*
 * Copyright 2011 Netzbewegung GmbH
 * All Rights Reserved.
 * 
 * NOTICE: Netzbewegung GmbH permits you to use, modify, and distribute this 
 * file in accordance with the terms of the license agreement accompanying it.
 *
 * Created by Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com> on 14.03.2011. 
 */
package com.pixelrebellen.sushiman.game
{
	import com.pixelrebellen.sushiman.game.config.GameConfig;
	import com.pixelrebellen.sushiman.game.events.GameEvent;
	import com.pixelrebellen.sushiman.game.events.GameModelEvent;
	import com.pixelrebellen.sushiman.game.levels.EndState;
	import com.pixelrebellen.sushiman.game.levels.Level_1;
	import com.pixelrebellen.sushiman.game.levels.Level_2;
	import com.pixelrebellen.sushiman.game.levels.Level_3;
	import com.pixelrebellen.sushiman.game.levels.StartState;
	import com.pixelrebellen.sushiman.game.models.GameModel;

	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import org.flixel.FlxState;
	import org.flixel.FlxU;

	import flash.display.Graphics;
	import flash.events.Event;





    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
     */
    public class Game extends FlxGame
    {
        private var states:Vector.<Class>;
		
		private var statePointer:int;
		
		private var gameModel:GameModel;
        
        public function Game()
        {
            gameModel = new GameModel();
			
			
			states = new Vector.<Class>();
            
            states.push(StartState);
            states.push(Level_1);
            states.push(Level_2);
            states.push(Level_3);
            states.push(EndState);
            
            super(855, 585, StartState, 1);
			FlxG.bgColor = 0xFFAA0A0A;
			
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(event : Event) : void
        {
        	stage.focus = stage;
        	removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			addEventListener(GameEvent.RESET_GAME_POINTER, onResetGame);
			
			
			//game main
			
			addEventListener(GameEvent.HERO_DIED, onHeroDied);
			addEventListener(GameEvent.ENEMY_DIED, onEnemyDied);
			
			addEventListener(GameEvent.ITEMS_1_COLLECTED, onItem1Collected);
			addEventListener(GameEvent.ITEMS_2_COLLECTED, onItem2Collected);
			addEventListener(GameEvent.ITEMS_3_COLLECTED, onItem3Collected);
			addEventListener(GameEvent.ITEMS_4_COLLECTED, onItem4Collected);

			addEventListener(GameEvent.ALL_ITEMS_COLLECTED, onAllItemsCollected);
			
			
		}

		private function onEnemyDied(event : GameEvent) : void
		{
			gameModel.enemies--;
			updateModel();
		}

		private function onResetGame(event : GameEvent) : void
		{
			start();
		}

		private function onAllItemsCollected(event : GameEvent) : void
		{
			statePointer++;
			var nextState:FlxState = new states[statePointer]();
			FlxG.switchState(nextState);
			
			if(nextState is EndState)
			{
				dispatchEvent(new GameModelEvent(GameModelEvent.GAME_OVER, gameModel));
			}
			
			gameModel.score += GameConfig.LEVEL_SCORE;
			
			gameModel.level = statePointer; 
			
			updateModel();
		}

		private function onItem4Collected(event : GameEvent) : void
		{
			gameModel.score += GameConfig.KILL_ITEM_SCORE;
			
			updateModel();
		}

		private function onItem3Collected(event : GameEvent) : void
		{
			gameModel.score += GameConfig.LIFE_ITEM_SCORE;
			gameModel.lifes++;
			
			updateModel();
		}

		private function onItem2Collected(event : GameEvent) : void
		{
			gameModel.score += GameConfig.BONUS_ITEM_SCORE;
			
			updateModel();
		}

		private function onItem1Collected(event : GameEvent) : void
		{
			gameModel.score += GameConfig.NORMAL_ITEM_SCORE;
			
			updateModel();
		}

		private function onHeroDied(event : GameEvent) : void
		{
			gameModel.lifes --;
			
			if(gameModel.lifes == 0)
			{
				FlxG.switchState(new EndState());
				dispatchEvent(new GameModelEvent(GameModelEvent.GAME_OVER, gameModel));
			}
				
			updateModel();
		}
		
		private function updateModel():void
		{
			dispatchEvent(new GameModelEvent(GameModelEvent.UPDATE, gameModel));
		}

		public function start() : void
		{
			statePointer = 1;
			
			gameModel = new GameModel();
			gameModel.level = 1;
			
			updateModel();
			
			FlxG.switchState(new StartState());
		}
		
		override protected function createFocusScreen():void
		{
			var gfx:Graphics = _focus.graphics;
			var screenWidth:uint = FlxG.width*FlxCamera.defaultZoom;
			var screenHeight:uint = FlxG.height*FlxCamera.defaultZoom;
			
			//draw transparent black backdrop
			gfx.moveTo(0,0);
			gfx.beginFill(0,0.5);
			gfx.lineTo(screenWidth,0);
			gfx.lineTo(screenWidth,screenHeight);
			gfx.lineTo(0,screenHeight);
			gfx.lineTo(0,0);
			gfx.endFill();
			
			//draw white arrow
			var halfWidth:uint = screenWidth/2;
			var halfHeight:uint = screenHeight/2;
			var helper:uint = FlxU.min(halfWidth,halfHeight)/3;
			gfx.moveTo(halfWidth-helper,halfHeight-helper);
			gfx.beginFill(0xffffff,0.65);
			gfx.lineTo(halfWidth+helper,halfHeight);
			gfx.lineTo(halfWidth-helper,halfHeight+helper);
			gfx.lineTo(halfWidth-helper,halfHeight-helper);
			gfx.endFill();
			
			addChild(_focus);
		}

    }
}
