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
	import com.pixelrebellen.sushiman.game.statics.LevelBackground;

	import org.flixel.FlxState;

	import flash.ui.Mouse;



    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
	 */
	public class EndState extends FlxState
    {
		public function EndState()
        {
            super();
        }
        
        override public function create():void
		{
			add(new LevelBackground());
			
			Mouse.show();
		}
    }
}
