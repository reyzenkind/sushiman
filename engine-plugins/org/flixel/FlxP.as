/*
 * Copyright 2011 Netzbewegung GmbH
 * All Rights Reserved.
 * 
 * NOTICE: Netzbewegung GmbH permits you to use, modify, and distribute this 
 * file in accordance with the terms of the license agreement accompanying it.
 *
 * Created by Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com> on 21.03.2011. 
 */
package org.flixel
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
     */
    public class FlxP
    {
    	public static function arrayRange(fromInc:int, toInc:int):Array
    	{
    		var array:Array = new Array();
    		
    		for(var i:int = fromInc; i <= toInc; i++)
    		{
    			array[array.length] = i;
    		}
    		
    		return array;
    	}
    	
    	
    	public static function movieClipClass2BitmapSeq(MovieClipClass:Class):Bitmap
    	{
    		var mc:MovieClip = new MovieClipClass();
			mc.stop();
			
			var mx:Number = Number.MAX_VALUE;
			var my:Number = Number.MAX_VALUE;
			
			var mw:Number = 0;
			var mh:Number = 0;
			
			var cw:Number = 0;
			var ch:Number = 0;
			
			var mcBounds:Rectangle;
			
			for(var i:int = 1; i <= mc.totalFrames; i++)
			{
				mc.gotoAndStop(i);
				
				mcBounds = mc.getBounds(mc);
				//trace(mcBounds);
                
				if(mcBounds.x + mcBounds.width  > mw) mw = mcBounds.x + mcBounds.width;
				if(mcBounds.y + mcBounds.height > mh) mh = mcBounds.y + mcBounds.height;
				
				if(mcBounds.x < mx) mx = mcBounds.x;
				if(mcBounds.y < my) my = mcBounds.y;
				
			}
			
			cw = mc.totalFrames * (mw - mx);
			ch = (mh - my);
			
			var btmd:BitmapData = new BitmapData(cw, ch, true, 0x00000000);
			
			
			var mcHolder:Sprite = new Sprite();
			var tmc:MovieClip;
			
			for(var j:int = 1; j <= mc.totalFrames; j++)
			{
				tmc = new MovieClipClass();
				tmc.gotoAndStop(j);
				
				//mcBounds = tmc.getBounds(tmc);
				
				tmc.x = (mw - mx) * (j - 1) - mx;
				tmc.y = - my; 
				
				mcHolder.addChild(tmc);
			}
			
			btmd.draw(mcHolder);
			
			var btm:Bitmap = new Bitmap(btmd);
			
			
			
			return btm;
    	}
    }
}
