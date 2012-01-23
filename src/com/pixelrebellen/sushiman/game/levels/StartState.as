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
	import com.pixelrebellen.sushiman.game.config.GameConfig;
	import com.pixelrebellen.sushiman.game.events.GameEvent;
	import com.pixelrebellen.sushiman.game.statics.LevelBackground;

	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import org.flixel.FlxState;

	import flash.ui.Mouse;




    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
     */
    public class StartState extends FlxState
    {
        protected var game:FlxGame = FlxG.game;
		
        public function StartState()
        {
            super();
        }
        
        override public function create():void
		{
			add(new LevelBackground());
			
			FlxG.mute = false;
            FlxG.volume = 2;
			Mouse.hide();
			
			game.dispatchEvent(new GameEvent(GameEvent.RESET_GAME_POINTER));
			
			FlxG.switchState(new GameConfig.START_LEVEL_CLASS());
		}
    }
}
