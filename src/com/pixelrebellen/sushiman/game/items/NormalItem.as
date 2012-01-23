package com.pixelrebellen.sushiman.game.items
{
	import com.pixelrebellen.sushiman.game.MovieClipBitmaps.NormalItemMovieClipBitmap;
	import org.flixel.FlxSprite;


	/**
	 * @author JESSA
	 */
	public class NormalItem extends FlxSprite implements ICollectable
	{
		private var _type:int = 1;

		public function NormalItem(X : Number = 0, Y : Number = 0, SimpleGraphic : Class = null)
		{
			super(X, Y, NormalItemMovieClipBitmap);
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
