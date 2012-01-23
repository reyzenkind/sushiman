/*
 * Copyright 2011 Netzbewegung GmbH
 * All Rights Reserved.
 * 
 * NOTICE: Netzbewegung GmbH permits you to use, modify, and distribute this 
 * file in accordance with the terms of the license agreement accompanying it.
 *
 * Created by Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com> on 15.03.2011. 
 */
package com.pixelrebellen.sushiman.game.characters
{
	import com.pixelrebellen.sushiman.game.MovieClipBitmaps.OctoMovieClipBitmap;
	import com.pixelrebellen.sushiman.game.config.GameConfig;
	import flash.geom.Point;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxP;
	import org.flixel.FlxPathfinding;
	import org.flixel.FlxPathfindingGroupe;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;



    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
     */
    public class Enemy extends FlxSprite
    {
        
		private var huntTarget:FlxObject;
        private var huntCallback : Function;
        private var huntTileMap : FlxTilemap;
        private var huntTileGroupe : FlxPathfindingGroupe;
        private var huntTargetEnemyRoundPoint:Point;
        
      	private var followTarget:FlxObject;
        private var followTileMap : FlxTilemap;
        private var followTileGroupe : FlxPathfindingGroupe;
        private var followDistance:int;
        private var followPursuiteVelocityVector:Point;
        private var followTargetEnemyRoundPoint:Point;
        private var activatePursuite:Boolean;
        
        private var freeWalkTileMap : FlxTilemap;
        private var freeWalkTileGroupe : FlxPathfindingGroupe;
        private var freeWalkTargetEnemyRoundPoint : Point;
        private var freeWalkLastEnemyRoundPoint : Point;
        
        private var startPosition:FlxPoint;
        
        private var virtualDirection:Point;
        
		
		private var _isHunted:Boolean;
		
		private var _type:int = -1;
        
        public function Enemy(X : Number = 0, Y : Number = 0)
        {
            super(X, Y);
            
            loadGraphic(OctoMovieClipBitmap, true, true, GameConfig.BASE_TILE_WIDTH, GameConfig.BASE_TILE_HEIGHT);
            
            startPosition = new FlxPoint();
            startPosition.x = X;
            startPosition.y = Y;
            
            virtualDirection = new Point();
            
            addAnimation("stay", [0]);
            addAnimation("walk", FlxP.arrayRange(0, 15), 25, true);
			addAnimation("readyhunted", [16]);
            addAnimation("hunted", FlxP.arrayRange(16, 32), 25, true);
            
            play("walk");
        }
        
        public function restart():void
        {
        	x = startPosition.x;
        	y = startPosition.y;
        	
        	huntTargetEnemyRoundPoint = null;
        	followTargetEnemyRoundPoint = null;
        	freeWalkTargetEnemyRoundPoint = null;
        	freeWalkLastEnemyRoundPoint = null;
        }
        
        public function resetAI():void
        {
        	huntTargetEnemyRoundPoint = null;
        	followTargetEnemyRoundPoint = null;
        	freeWalkTargetEnemyRoundPoint = null;
        	freeWalkLastEnemyRoundPoint = null;
        	
        	freeWalkTileMap = null;
        	huntTarget = null;
        	huntTileMap = null;
        	
        	followTarget = null;
        	followTileMap = null;
        }
        
        
        public function huntFor(target:FlxObject, map:FlxTilemap, groupe:FlxPathfindingGroupe = null, callback:Function = null):void
        {
        	huntTarget = target;
        	huntCallback = callback;
        	huntTileMap = map;
        	huntTileGroupe = groupe;
			
			_type = 0;
        }
        
        public function follorA(target:FlxObject, map:FlxTilemap, groupe:FlxPathfindingGroupe = null, dist:int = 1, fpvv:Point = null):void
        {
        	followTarget = target;
        	followDistance = dist;
        	followTileMap = map;
        	followTileGroupe = groupe;
        	followPursuiteVelocityVector = fpvv == null ? new Point(20,20) : fpvv;
        	activatePursuite = false;
			
			_type = 1;
        }
        
        public function freeWalk(map:FlxTilemap, groupe:FlxPathfindingGroupe = null):void
        {
        	freeWalkTileMap = map;
        	freeWalkTileGroupe = groupe;
			
			_type = 2;
        }
        
        override public function update():void
        {
        	
			updateAnimationView();
			updateHuntView();
			updateFollowView();
			updateFreeWalkView();
        	
        	super.update();
        }
        
        private function updateAnimationView():void
        {
        	if((virtualDirection.x != 0 || virtualDirection.y != 0))
        	{
        		if(_isHunted)
				{
					play("hunted");	
				}
				else
				{
					play("walk");
				}
        	}
        	else
        	{
        		if(_isHunted)
				{
					play("readyhunted");	
				}
				else
				{
					play("stay");
				}
        	}
        	
        	
        	if(virtualDirection.x < 0) facing = FlxObject.LEFT;
        	if(virtualDirection.x > 0) facing = FlxObject.RIGHT;
        	
//        	if(virtualDirection.y < 0) angle = 180;
//        	if(virtualDirection.y > 0) angle = 0;
        }
        
        private function updateFreeWalkView():void
        {
        	
        	if(freeWalkTileMap == null) return;
        	
        	virtualDirection = new Point();
        	
        	var currentEnemyPoint:Point = new Point(this.x, this.y);
        	freeWalkTargetEnemyRoundPoint = freeWalkTargetEnemyRoundPoint == null ? new Point(int(this.x/GameConfig.BASE_TILE_WIDTH)*GameConfig.BASE_TILE_WIDTH, int(this.y/GameConfig.BASE_TILE_HEIGHT)*GameConfig.BASE_TILE_HEIGHT) : freeWalkTargetEnemyRoundPoint;
        	var currentEnemyTilePoint:Point = new Point(int(this.x/GameConfig.BASE_TILE_WIDTH), int(this.y/GameConfig.BASE_TILE_HEIGHT));
        	
        	if(currentEnemyPoint.x != freeWalkTargetEnemyRoundPoint.x || currentEnemyPoint.y != freeWalkTargetEnemyRoundPoint.y)
        	{
        		
        		if(currentEnemyPoint.x != freeWalkTargetEnemyRoundPoint.x)
        		{
        			var directionX:int = (freeWalkTargetEnemyRoundPoint.x - currentEnemyPoint.x)/Math.abs(freeWalkTargetEnemyRoundPoint.x - currentEnemyPoint.x);
        			virtualDirection.x = directionX;
        			var nextStepX:Number = currentEnemyPoint.x + directionX * GameConfig.ENEMY_VELOCITY_X * FlxG.elapsed;
        			
        			if((directionX < 0 && nextStepX < freeWalkTargetEnemyRoundPoint.x) || (directionX > 0 && nextStepX > freeWalkTargetEnemyRoundPoint.x))
        			{
        				nextStepX = freeWalkTargetEnemyRoundPoint.x;
        			}
        			
        			this.x  = nextStepX;
        		}
        		
        		if(currentEnemyPoint.y != freeWalkTargetEnemyRoundPoint.y)
        		{
        			var directionY:int = (freeWalkTargetEnemyRoundPoint.y - currentEnemyPoint.y)/Math.abs(freeWalkTargetEnemyRoundPoint.y - currentEnemyPoint.y);
        			virtualDirection.y = directionY;
        			var nextStepY:Number = currentEnemyPoint.y + directionY * GameConfig.ENEMY_VELOCITY_Y * FlxG.elapsed;
        			
        			if((directionY < 0 && nextStepY < freeWalkTargetEnemyRoundPoint.y) || (directionY > 0 && nextStepY > freeWalkTargetEnemyRoundPoint.y))
        			{
        				nextStepY = freeWalkTargetEnemyRoundPoint.y;
        			}
        			
        			this.y  = nextStepY;
        		}
        	}
        	else
        	{

        		freeWalkLastEnemyRoundPoint = freeWalkLastEnemyRoundPoint == null ? currentEnemyTilePoint : freeWalkLastEnemyRoundPoint;
        		
        		var pf:FlxPathfinding = new FlxPathfinding(freeWalkTileMap, freeWalkTileGroupe);
				pf.allowDiagonal = false;
				
				var pointArray:Array = pf.getNeighborPointsForNodeAt(currentEnemyTilePoint.x, currentEnemyTilePoint.y);
				//trace(pointArray);
				if(pointArray.length == 0) return;
				
				if(pointArray.length > 1)
				{
					var pointForSearch:Point;
					var searchArray:Array = new Array();
					for(var i:int = 0; i < pointArray.length; i++)
					{
						pointForSearch = Point(pointArray[i]);
						if(pointForSearch.x != freeWalkLastEnemyRoundPoint.x || pointForSearch.y != freeWalkLastEnemyRoundPoint.y)
						{
							searchArray.push(pointForSearch);
						}
					}
//					trace("pointArray : ", pointArray, " --> ", freeWalkLastEnemyRoundPoint);
//					trace("searchArray : ", searchArray);
					
					pointArray = searchArray;
				}
				
				freeWalkLastEnemyRoundPoint = currentEnemyTilePoint;
				
				var pointIndex:int = Math.round(Math.random() * (pointArray.length-1));
				
				var freeWalkTarget:Point = Point(pointArray[pointIndex]);
				freeWalkTarget = new Point(freeWalkTarget.x * GameConfig.BASE_TILE_WIDTH,  freeWalkTarget.y * GameConfig.BASE_TILE_HEIGHT);

				
				var enemyPosition:Point = currentEnemyTilePoint;
				
	        	var freeWalkTargetPosition:Point = new Point();
	        	freeWalkTargetPosition.x = int((freeWalkTarget.x - freeWalkTileMap.x)/GameConfig.BASE_TILE_WIDTH);
	        	freeWalkTargetPosition.y = int((freeWalkTarget.y - freeWalkTileMap.y)/GameConfig.BASE_TILE_HEIGHT);
	        	
	        	var path:Array = pf.findPath(enemyPosition, freeWalkTargetPosition);
	        	
	        	if(path.length == 0) return;
	        	
	        	var pointToMove:Point = path[0]; 
	        	
	        	freeWalkTargetEnemyRoundPoint = new Point(pointToMove.x * GameConfig.BASE_TILE_WIDTH, pointToMove.y * GameConfig.BASE_TILE_HEIGHT);
	        	
	        	var newEnemyStateVectorPoint:Point = new Point(pointToMove.x - enemyPosition.x, pointToMove.y - enemyPosition.y);
	        	
	        	this.x += newEnemyStateVectorPoint.x * GameConfig.ENEMY_VELOCITY_X * FlxG.elapsed;
        		this.y += newEnemyStateVectorPoint.y * GameConfig.ENEMY_VELOCITY_Y * FlxG.elapsed;
        		
        	}
        }
        
        private function updateHuntView():void
        {
        	if(huntTarget == null || huntTileMap == null) return;
        	
        	virtualDirection = new Point();
        	
        	var currentEnemyPoint:Point = new Point(this.x, this.y);
        	huntTargetEnemyRoundPoint = huntTargetEnemyRoundPoint == null ? new Point(int(this.x/GameConfig.BASE_TILE_WIDTH)*GameConfig.BASE_TILE_WIDTH, int(this.y/GameConfig.BASE_TILE_HEIGHT)*GameConfig.BASE_TILE_HEIGHT) : huntTargetEnemyRoundPoint;
        	var currentEnemyTilePoint:Point = new Point(int(this.x/GameConfig.BASE_TILE_WIDTH), int(this.y/GameConfig.BASE_TILE_HEIGHT));
        	
        	if(currentEnemyPoint.x != huntTargetEnemyRoundPoint.x || currentEnemyPoint.y != huntTargetEnemyRoundPoint.y)
        	{
        		
        		if(currentEnemyPoint.x != huntTargetEnemyRoundPoint.x)
        		{
        			var directionX:int = (huntTargetEnemyRoundPoint.x - currentEnemyPoint.x)/Math.abs(huntTargetEnemyRoundPoint.x - currentEnemyPoint.x);
        			virtualDirection.x = directionX;
        			var nextStepX:Number = currentEnemyPoint.x + directionX * GameConfig.ENEMY_VELOCITY_X * FlxG.elapsed;
        			
        			if((directionX < 0 && nextStepX < huntTargetEnemyRoundPoint.x) || (directionX > 0 && nextStepX > huntTargetEnemyRoundPoint.x))
        			{
        				nextStepX = huntTargetEnemyRoundPoint.x;
        			}
        			
        			this.x  = nextStepX;
        		}
        		
        		if(currentEnemyPoint.y != huntTargetEnemyRoundPoint.y)
        		{
        			var directionY:int = (huntTargetEnemyRoundPoint.y - currentEnemyPoint.y)/Math.abs(huntTargetEnemyRoundPoint.y - currentEnemyPoint.y);
        			virtualDirection.y = directionY;
        			var nextStepY:Number = currentEnemyPoint.y + directionY * GameConfig.ENEMY_VELOCITY_Y * FlxG.elapsed;
        			
        			if((directionY < 0 && nextStepY < huntTargetEnemyRoundPoint.y) || (directionY > 0 && nextStepY > huntTargetEnemyRoundPoint.y))
        			{
        				nextStepY = huntTargetEnemyRoundPoint.y;
        			}
        			
        			this.y  = nextStepY;
        		}
        	}
        	else
        	{

        		var pf:FlxPathfinding = new FlxPathfinding(huntTileMap, huntTileGroupe);
				pf.allowDiagonal = false;
				
				var enemyPosition:Point = currentEnemyTilePoint;
				
	        	var huntTargetPosition:Point = new Point();
	        	huntTargetPosition.x = int((huntTarget.x - huntTileMap.x)/GameConfig.BASE_TILE_WIDTH);
	        	huntTargetPosition.y = int((huntTarget.y - huntTileMap.y)/GameConfig.BASE_TILE_HEIGHT);
	        	
	        	var path:Array = pf.findPath(enemyPosition, huntTargetPosition);
	        	
	        	if(path.length == 0) return;
	        	
	        	var pointToMove:Point = path[0]; 
	        	
	        	huntTargetEnemyRoundPoint = new Point(pointToMove.x * GameConfig.BASE_TILE_WIDTH, pointToMove.y * GameConfig.BASE_TILE_HEIGHT);
	        	
	        	var newEnemyStateVectorPoint:Point = new Point(pointToMove.x - enemyPosition.x, pointToMove.y - enemyPosition.y);
	        	
	        	this.x += newEnemyStateVectorPoint.x * GameConfig.ENEMY_VELOCITY_X * FlxG.elapsed;
        		this.y += newEnemyStateVectorPoint.y * GameConfig.ENEMY_VELOCITY_Y * FlxG.elapsed;
        		
        	}
        	
//        	FlxU.overlap(huntTarget, this,  huntCallback);
        }
        
        
        private function updateFollowView():void
        {
        	if(followTarget == null || followTileMap == null) return;
        	
        	virtualDirection = new Point();
        	
        	var pursuiteVector:Point = activatePursuite ? followPursuiteVelocityVector : new Point(0,0);
        	
        	var currentEnemyPoint:Point = new Point(this.x, this.y);
        	followTargetEnemyRoundPoint = followTargetEnemyRoundPoint == null ? new Point(int(this.x/GameConfig.BASE_TILE_WIDTH)*GameConfig.BASE_TILE_WIDTH, int(this.y/GameConfig.BASE_TILE_HEIGHT)*GameConfig.BASE_TILE_HEIGHT) : followTargetEnemyRoundPoint;
        	var currentEnemyTilePoint:Point = new Point(int(this.x/GameConfig.BASE_TILE_WIDTH), int(this.y/GameConfig.BASE_TILE_HEIGHT));
        	
        	if(currentEnemyPoint.x != followTargetEnemyRoundPoint.x || currentEnemyPoint.y != followTargetEnemyRoundPoint.y)
        	{
        		
        		if(currentEnemyPoint.x != followTargetEnemyRoundPoint.x)
        		{
        			var directionX:int = (followTargetEnemyRoundPoint.x - currentEnemyPoint.x)/Math.abs(followTargetEnemyRoundPoint.x - currentEnemyPoint.x);
        			virtualDirection.x = directionX;
        			var nextStepX:Number = currentEnemyPoint.x + directionX * (GameConfig.ENEMY_VELOCITY_X + pursuiteVector.x) * FlxG.elapsed;
        			
        			if((directionX < 0 && nextStepX < followTargetEnemyRoundPoint.x) || (directionX > 0 && nextStepX > followTargetEnemyRoundPoint.x))
        			{
        				nextStepX = followTargetEnemyRoundPoint.x;
        			}
        			
        			this.x  = nextStepX;
        		}
        		
        		if(currentEnemyPoint.y != followTargetEnemyRoundPoint.y)
        		{
        			var directionY:int = (followTargetEnemyRoundPoint.y - currentEnemyPoint.y)/Math.abs(followTargetEnemyRoundPoint.y - currentEnemyPoint.y);
        			virtualDirection.y = directionY;
        			var nextStepY:Number = currentEnemyPoint.y + directionY * (GameConfig.ENEMY_VELOCITY_Y + pursuiteVector.y) * FlxG.elapsed;
        			
        			if((directionY < 0 && nextStepY < followTargetEnemyRoundPoint.y) || (directionY > 0 && nextStepY > followTargetEnemyRoundPoint.y))
        			{
        				nextStepY = followTargetEnemyRoundPoint.y;
        			}
        			
        			this.y  = nextStepY;
        		}
        	}
        	else
        	{

        		var pf:FlxPathfinding = new FlxPathfinding(followTileMap, followTileGroupe);
				pf.allowDiagonal = false;
				
				var enemyPosition:Point = currentEnemyTilePoint;
				
	        	var huntTargetPosition:Point = new Point();
	        	huntTargetPosition.x = int((followTarget.x - followTileMap.x)/GameConfig.BASE_TILE_WIDTH);
	        	huntTargetPosition.y = int((followTarget.y - followTileMap.y)/GameConfig.BASE_TILE_HEIGHT);
	        	
	        	var path:Array = pf.findPath(enemyPosition, huntTargetPosition);
	        	
	        	if(path.length < followDistance) return;
	        	
	        	activatePursuite = (path.length > followDistance);
	        	
	        	var pointToMove:Point = path[0]; 
	        	
	        	followTargetEnemyRoundPoint = new Point(pointToMove.x * GameConfig.BASE_TILE_WIDTH, pointToMove.y * GameConfig.BASE_TILE_HEIGHT);
	        	
	        	var newEnemyStateVectorPoint:Point = new Point(pointToMove.x - enemyPosition.x, pointToMove.y - enemyPosition.y);
	        	
	        	this.x += newEnemyStateVectorPoint.x * (GameConfig.ENEMY_VELOCITY_X + pursuiteVector.x) * FlxG.elapsed;
        		this.y += newEnemyStateVectorPoint.y * (GameConfig.ENEMY_VELOCITY_Y + pursuiteVector.y)* FlxG.elapsed;
        		
			}
		}

		public function get isHunted() : Boolean
		{
			return _isHunted;
		}

		public function set isHunted(value : Boolean) : void
		{
			_isHunted = value;
		}

		public function get type() : int
		{
			return _type;
		}

    }
}
