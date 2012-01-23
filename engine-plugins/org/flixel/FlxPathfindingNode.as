package org.flixel
{
	
	/**
	* ...
	* @author Vexhel
	*/
	public class FlxPathfindingNode {
		
		public var x:int;
		public var y:int;
		public var g:int = 0;
		public var h:int = 0;
		public var f:int = 0;
		public var cost:int;
		public var parent:FlxPathfindingNode = null;
		public var walkable:Boolean;
		public var tileObject:FlxObject;


		function FlxPathfindingNode(x:int, y:int, walkable:Boolean = true , tileObject:FlxObject = null)
		{
			this.x = x;
			this.y = y;
			this.walkable = walkable;
			this.tileObject = tileObject;
		}
		
		public function toString():String
		{
			return "[ " +"x: " + x + " " + " " + "y: " + y + " " + "walkable: " + walkable + " ]";
        }

        public function isTileWalkable(direction : uint) : Boolean
        {
            if(tileObject == null) return true;
            return tileObject.allowCollisions & direction ? false : true;
        }
	}
}

