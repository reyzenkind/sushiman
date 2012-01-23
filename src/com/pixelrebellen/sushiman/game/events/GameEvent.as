package com.pixelrebellen.sushiman.game.events
{
	import flash.events.Event;

	/**
	 * @author JESSA
	 */
	public class GameEvent extends Event
	{
		public static const HERO_DIED : String = "HERO_DIED";
		public static const ENEMY_DIED : String = "ENEMY_DIED";
		public static const ALL_ITEMS_COLLECTED : String = "ALL_ITEMS_COLLECTED";
		
		public static const ITEMS_1_COLLECTED : String = "ITEMS_1_COLLECTED";
		public static const ITEMS_2_COLLECTED : String = "ITEMS_2_COLLECTED";
		public static const ITEMS_3_COLLECTED : String = "ITEMS_3_COLLECTED";
		public static const ITEMS_4_COLLECTED : String = "ITEMS_4_COLLECTED";
		
		
		
		public static const RESET_GAME_POINTER : String = "RESET_GAME_POINTER";
		
		public function GameEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
