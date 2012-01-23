package com.pixelrebellen.core.math
{
	/**
	 * @author JESSA
	 */
	public class Random
	{
		public static function rBoolean():Boolean
		{
			return (Math.random() > .5) ? true : false;
		}
		
		public static function rNumber(min:Number, max:Number):Number
		{
			return Math.random() * (max - min) + min;	
		}
		
		public static function rInt(min:int, max:int):Number
		{
			return Math.floor(rNumber(min, max));	
		}
	}
}
