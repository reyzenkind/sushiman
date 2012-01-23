package com.pixelrebellen.sushiman.game.statics
{
	import com.pixelrebellen.sushiman.game.MovieClipBitmaps.SpawnPlaceMovieClipBitmap;

	import org.flixel.FlxSprite;


	/**
	 * @author JESSA
	 */
	public class SpawnPlace extends FlxSprite
	{
		public function SpawnPlace(X : Number = 0, Y : Number = 0, SimpleGraphic : Class = null)
		{
			super(X, Y, SpawnPlaceMovieClipBitmap);
		}
	}
}
