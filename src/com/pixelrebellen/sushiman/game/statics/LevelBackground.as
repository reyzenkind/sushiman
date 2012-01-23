package com.pixelrebellen.sushiman.game.statics
{
	import com.pixelrebellen.sushiman.game.MovieClipBitmaps.LevelBackgroundMovieClipBitmap;

	import org.flixel.FlxSprite;


	/**
	 * @author JESSA
	 */
	public class LevelBackground extends FlxSprite
	{
		public function LevelBackground(X : Number = 0, Y : Number = 0, SimpleGraphic : Class = null)
		{
			super(X, Y, LevelBackgroundMovieClipBitmap);
		}
	}
}
