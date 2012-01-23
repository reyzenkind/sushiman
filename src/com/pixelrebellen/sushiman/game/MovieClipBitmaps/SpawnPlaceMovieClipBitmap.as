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
	import com.pixelrebellen.sushiman.assets.SpawnPlaceAsset;

	import org.flixel.FlxP;

	import flash.display.Bitmap;

    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
	 */
	public class SpawnPlaceMovieClipBitmap extends Bitmap
	{
		public function SpawnPlaceMovieClipBitmap(pixelSnapping : String = "auto", smoothing : Boolean = false)
        {
            super(FlxP.movieClipClass2BitmapSeq(SpawnPlaceAsset).bitmapData, pixelSnapping, smoothing);
        }
    }
}
