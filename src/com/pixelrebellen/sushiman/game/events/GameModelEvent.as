package com.pixelrebellen.sushiman.game.events
{
	import com.pixelrebellen.sushiman.game.models.GameModel;

	import flash.events.Event;

	/**
	 * @author JESSA
	 */
	public class GameModelEvent extends Event
	{
		public static const UPDATE : String = "UPDATE";
		
		public static const GAME_OVER : String = "GAME_OVER";
		
		public var model:GameModel;
		
		public function GameModelEvent(type : String, model:GameModel, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.model = model;
		}
	}
}
