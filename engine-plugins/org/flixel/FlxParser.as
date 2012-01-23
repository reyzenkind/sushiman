package org.flixel
{
	/**
	 * @author JESSA
	 */
	public class FlxParser
	{
		public function parseCSV(value:String):Array
		{
			var result:Array = [];
			
			result = value.split("\n");
			
			for(var i:int = 0; i < result.length; i++)
			{
				result[i] = String(result[i]).split(",");
			}
			
			return result;
			
		}
	}
}
