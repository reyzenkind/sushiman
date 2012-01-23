/*
 * Copyright 2011 Netzbewegung GmbH
 * All Rights Reserved.
 * 
 * NOTICE: Netzbewegung GmbH permits you to use, modify, and distribute this 
 * file in accordance with the terms of the license agreement accompanying it.
 *
 * Created by Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com> on 21.03.2011. 
 */
package com.pixelrebellen.sushiman.game.MovieClipBitmaps
{
	import com.pixelrebellen.sushiman.assets.KillItemAsset;

	import org.flixel.FlxP;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
	 */
	public class KillItemMovieClipBitmap extends Bitmap
	{
		public function KillItemMovieClipBitmap(bitmapData : BitmapData = null, pixelSnapping : String = "auto", smoothing : Boolean = false)
        {
            bitmapData;
			super(FlxP.movieClipClass2BitmapSeq(KillItemAsset).bitmapData, pixelSnapping, smoothing);
        }
    }
}
