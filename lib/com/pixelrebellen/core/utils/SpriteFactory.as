/*
 * Copyright 2011 Netzbewegung GmbH
 * All Rights Reserved.
 * 
 * NOTICE: Netzbewegung GmbH permits you to use, modify, and distribute this 
 * file in accordance with the terms of the license agreement accompanying it.
 *
 * Created by Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com> on 21.10.2011. 
 */
package com.pixelrebellen.core.utils
{
	import flash.display.Sprite;
    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
     */
    public class SpriteFactory
    {
        public static function createRectSprite(width:Number, height:Number, alpha:Number = 0, color:uint = 0xFF0000):Sprite
        {
            var s:Sprite = new Sprite();
            s.graphics.beginFill(color, alpha);
            s.graphics.drawRect(0, 0, width, height);
            s.graphics.endFill();
            return(s);
            
        }
        
        public static function createRectBorderSprite(width:Number, height:Number, alpha:Number = 0, color:uint = 0xFF0000 , thickness : Number = undefined, bColor : uint = 0, bAlpha : Number = 1.0):Sprite
        {
            var s:Sprite = new Sprite();
            s.graphics.lineStyle(thickness, bColor, bAlpha);
            s.graphics.beginFill(color, alpha);
            s.graphics.drawRect(0, 0, width, height);
            s.graphics.endFill();
            return(s);
            
        }
    }
}
