package com.pixelrebellen.sushiman.game.items
{
	import com.pixelrebellen.sushiman.game.MovieClipBitmaps.LifeItemMovieClipBitmap;
	import org.flixel.FlxSprite;


	/**
	 * @author JESSA
	 */
	public class LifeItem extends FlxSprite implements ICollectable
	{
		private var _type:int = 3;

		public function LifeItem(X : Number = 0, Y : Number = 0, SimpleGraphic : Class = null)
		{
			super(X, Y, LifeItemMovieClipBitmap);
		}



		public function get type() : int
		{
			return _type;
		}

		public function set type(value : int) : void
		{
			_type = value;
		}
	}
}
