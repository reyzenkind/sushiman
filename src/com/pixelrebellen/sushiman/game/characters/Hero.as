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
	import com.pixelrebellen.sushiman.game.MovieClipBitmaps.HeroMovieClipBitmap;
	import com.pixelrebellen.sushiman.game.config.GameConfig;
	import flash.geom.Point;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxP;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTimer;



    /**
     * @author Eugen Reyzenkind <e.reyzenkind[at]netzbewegung.com>
     */
    public class Hero extends FlxSprite
    {
        
		public var startPosition:FlxPoint;
		
		
		private var lastVelocityVector:Point = new Point();
        private var trackLastPoint:Point = new Point();
		
		
		private var _isHunting:Boolean;
		
		private var huntTimer : FlxTimer;
		
        public function Hero(X : Number = 0, Y : Number = 0)
        {
            super(X, Y);
            loadGraphic(HeroMovieClipBitmap, true, true, 45, 45);
            
            startPosition = new FlxPoint();
            startPosition.x = X;
            startPosition.y = Y;
            
            addAnimation("stay", [0]);
            addAnimation("walk", FlxP.arrayRange(0, 16), 25, true);
			addAnimation("readyhunt", [17]);
            addAnimation("hunt", FlxP.arrayRange(17, 33), 25, true);
            
            
//            offset.x = GameConfig.BASE_TILE_WIDTH  - width  >> 1;
//            offset.y = GameConfig.BASE_TILE_HEIGHT - height >> 1;
            
            _isHunting = false;
			
            play("stay");
			
        }
        
        public function restart():void
        {
        	visible = true;
        	
        	x = startPosition.x;
        	y = startPosition.y;
        	
        	lastVelocityVector = new Point();
			trackLastPoint = new Point(x, y);
			
			facing = FlxObject.RIGHT;
			
        	//walkSound.stop();
        	//walkSoundPlayed = false;
        }
        
        
        override public function update():void
        {
			updateAnimationView();
        	updateMoveView();
        	
        	super.update();
        	
        	//trace(x, y);
        	
        }
        
        
        
        private function updateMoveView():void
        {
        	

			if(FlxG.keys.pressed("LEFT"))
        	{
        		velocity.x = -GameConfig.HERO_VELOCITY_X;
        		lastVelocityVector.x = -1;
				
				facing = FlxObject.LEFT;
        	}
        	
        	if(FlxG.keys.pressed("RIGHT"))
        	{
        		velocity.x = +GameConfig.HERO_VELOCITY_X;
        		lastVelocityVector.x = +1;
				
				facing = FlxObject.RIGHT;
        	}
        	
        	if(FlxG.keys.pressed("UP"))
        	{
        		velocity.y = -GameConfig.HERO_VELOCITY_Y;
        		lastVelocityVector.y = -1;
        	}
        	
        	if(FlxG.keys.pressed("DOWN"))
        	{
        		velocity.y = +GameConfig.HERO_VELOCITY_Y;
        		lastVelocityVector.y = +1;
        	}
        	
        	if(!FlxG.keys.pressed("LEFT") && !FlxG.keys.pressed("RIGHT"))
        	{
        		var centerX:Number = x + width/2;
        		var projectedX:int = (int(centerX/GameConfig.BASE_TILE_WIDTH)) * (GameConfig.BASE_TILE_WIDTH);
        		
        		
        		if(velocity.x > 0)
        		{
        			if(centerX <= projectedX + GameConfig.BASE_TILE_WIDTH/2)
        			{
        				projectedX = projectedX;
        			}
        			else
        			{
        				projectedX = projectedX + GameConfig.BASE_TILE_WIDTH;
        			}
        			
        			if(x + velocity.x * FlxG.elapsed > projectedX)
        			{
        				x = projectedX;
        				velocity.x = 0;
        			}
        		}
        		else 
        		if(velocity.x < 0)
        		{
        			if(centerX >= projectedX + GameConfig.BASE_TILE_WIDTH/2)
        			{
        				projectedX = projectedX;
        			}
        			else
        			{
        				projectedX = projectedX - GameConfig.BASE_TILE_WIDTH;
        			}
        			
        			if(x + velocity.x * FlxG.elapsed < projectedX)
        			{
        				x = projectedX;
        				velocity.x = 0;
        			}
        		}
        	}
        	
        	if(!FlxG.keys.pressed("UP") && !FlxG.keys.pressed("DOWN"))
        	{
        		var centerY:Number = y + height/2;
        		var projectedY:int = (int(centerY/GameConfig.BASE_TILE_HEIGHT)) * (GameConfig.BASE_TILE_HEIGHT);
        		
        		if(velocity.y > 0)
        		{
        			if(centerY <= projectedY + GameConfig.BASE_TILE_HEIGHT/2)
        			{
        				projectedY = projectedY;
        			}
        			else
        			{
        				projectedY = projectedY + GameConfig.BASE_TILE_HEIGHT;
        			}
        			
        			if(y + velocity.y * FlxG.elapsed > projectedY)
        			{
        				y = projectedY;
        				velocity.y = 0;
        			}
        		}
        		else 
        		if(velocity.y < 0)
        		{
        			if(centerY >= projectedY + GameConfig.BASE_TILE_HEIGHT/2)
        			{
        				projectedY = projectedY;
        			}
        			else
        			{
        				projectedY = projectedY - GameConfig.BASE_TILE_HEIGHT;
        			}
        			
        			if(y + velocity.y * FlxG.elapsed < projectedY)
        			{
        				y = projectedY;
        				velocity.y = 0;
        			}
        		}
        	}
        	if(trackLastPoint.x == x)
        	{
        		x = Math.round(x);
        	}
        	trackLastPoint.x = x;
        	
        	if(trackLastPoint.y == y)
        	{
        		y = Math.round(y);
        	}
        	trackLastPoint.y = y;
			
			
        }
        
        override public function kill():void
        {
        	super.kill();
        }
        
        
        private function updateAnimationView():void
        {
        	
        	if(velocity.x != 0 || velocity.y != 0)
        	{
        		if(_isHunting)
				{
					play("hunt");	
				}
				else
				{
					play("walk");
				}
				
				
        	}
        	else
        	{
        		if(_isHunting)
				{
					play("readyhunt");	
				}
				else
				{
					play("stay");
				}
        	}
		}

		public function get isHunting() : Boolean
		{
			return _isHunting;
		}

		public function set isHunting(value : Boolean) : void
		{
			_isHunting = value;
			
			if(huntTimer != null)
			{
				huntTimer.destroy();
			}
			
			huntTimer = new FlxTimer();
			huntTimer.start(GameConfig.HUNT_TIME, 0, onHuntComplete);
		}
		
		private function onHuntComplete(pHuntTimer:FlxTimer):void
		{
			pHuntTimer.destroy();
			
			_isHunting = false;
		}

    }
}
