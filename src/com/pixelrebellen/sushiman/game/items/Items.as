package com.pixelrebellen.sushiman.game.items
{
	import com.pixelrebellen.sushiman.game.config.GameConfig;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;


	/**
	 * @author JESSA
	 */
	public class Items extends FlxGroup
	{
		public function Items(levelData:Array, itemTypes:Array, MaxSize : uint = 0)
		{
			super(MaxSize);
			
			var btW:Number = GameConfig.BASE_TILE_WIDTH;
			var btH:Number = GameConfig.BASE_TILE_HEIGHT;
			
			var freeSpaces:int = 0;
			
			
			var i:int;
			for(i = 0; i < levelData.length; i++)
			{
				levelData[i] = levelData[i] == 0 ? 1 : 0;
				
				freeSpaces += levelData[i];
			}
			
			if(!validate(freeSpaces, itemTypes)) return;
			
			
			var itemIndexes:Array = [];
			
			for(var j:int = 0; j < itemTypes.length; j++)
			{
				itemIndexes = itemIndexes.concat(generateArray(j + 2, itemTypes[j]));
			}
			
			itemIndexes = itemIndexes.concat(generateArray(1, freeSpaces - itemIndexes.length));
			itemIndexes.sort(rndSort);
			itemIndexes.sort(rndSort);
			
			//trace(itemIndexes);
			
			var pointer:int = 0;
			var item:FlxSprite;
			for(i = 0; i < levelData.length; i++)
			{
				
				if(levelData[i] == 1)
				{
					if(itemIndexes[pointer] == 2)
					{
						item = new BonusItem();
					}
					else
					if(itemIndexes[pointer] == 3)
					{
						item = new LifeItem();
					}
					else
					if(itemIndexes[pointer] == 4)
					{
						item = new KillItem();
					}
					else
					{
						item = new NormalItem();
					}
					
					add(item);
					
					item.x = btW * (i%GameConfig.BASE_MAP_WIDTH);
					item.y = btH * (Math.floor(i/GameConfig.BASE_MAP_WIDTH));
					
					pointer++;
				}
				
			}
			
			return;
			
			
			var sushi:KillItem = new KillItem();
			add(sushi);
			
			sushi.x = btW * 3;
			sushi.y = btH * 6;
			
		}
		
		private function validate(totalCount:int, items:Array):Boolean
		{
			var summ:int = 0;
			
			for(var i:int = 0; i < items.length; i++)
			{
				summ += items[i];
			}
			
			return totalCount > summ;
		}
		
		private function generateArray(element:int, count:int):Array
		{
			var result:Array = new Array(count);
			
			for(var i:int = 0; i < result.length; i++)
			{
				result[i] = element;
			}
			
			
			return result;
		}
		
		private function rndSort(a:int, b:int):Number
		{
			a;
			b;
			var num : Number = Math.round(Math.random()*2)-1;
			return num;
		}
		
		
	}
}
