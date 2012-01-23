package org.flixel.data
{
	/**
	 * Just a helper structure for the FlxSprite animation system
	 */
	public class FlxMovieClipAnim
	{
		/**
		 * String name of the animation (e.g. "walk")
		 */
		public var name:String;
		
		public var startFrame:int;
		
		public var endFrame:int;
		
		public var loop:int;
		
		public function FlxMovieClipAnim(Name:String, startFrame:int, endFrame:int,  loop:int = -1)
		{
			this.name = Name;
			this.startFrame = startFrame;
			this.endFrame = endFrame;
			this.loop = loop;
		}
	}
}