package com.pixelrebellen.sushiman.game.items
{
	import com.pixelrebellen.sushiman.game.MovieClipBitmaps.KillItemMovieClipBitmap;
	import org.flixel.FlxSprite;


	/**
	 * @author JESSA
	 */
	public class KillItem extends FlxSprite implements ICollectable
	{
		private var _type:int = 4;
		
		public function KillItem(X : Number = 0, Y : Number = 0, SimpleGraphic : Class = null)
		{
			super(X, Y, KillItemMovieClipBitmap);
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
