package com.pixelrebellen.sushiman.game.items
{
	import com.pixelrebellen.sushiman.game.MovieClipBitmaps.BonusItemMovieClipBitmap;
	import org.flixel.FlxSprite;


	/**
	 * @author JESSA
	 */
	public class BonusItem extends FlxSprite implements ICollectable
	{
		private var _type:int = 2;

		public function BonusItem(X : Number = 0, Y : Number = 0, SimpleGraphic : Class = null)
		{
			super(X, Y, BonusItemMovieClipBitmap);
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
