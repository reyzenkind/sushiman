package com.pixelrebellen.sushiman.hud
{
	import com.pixelrebellen.core.text.HtmlTextField;
	import com.pixelrebellen.core.text.TextFieldFactory;
	import com.pixelrebellen.sushiman.assets.HudAsset;

	import flash.display.Sprite;

	/**
	 * @author JESSA
	 */
	public class Hud extends Sprite
	{
		private var bg:HudAsset;
		
		private var enemiesTextfield:HtmlTextField;
		private var scoresTextfield:HtmlTextField;
		private var lifesTextfield : HtmlTextField;
		private var levelTextfield : HtmlTextField;
		
		private var texts:Array;
		
		public function Hud()
		{
			texts = [];
			texts[texts.length] = "";
			texts[texts.length] = "Sushi Kid";
			texts[texts.length] = "Kitchen Panic";
			texts[texts.length] = "I'm Sushinja";
			
			bg = new HudAsset();
			addChild(bg); 
			
			enemiesTextfield = TextFieldFactory.createHtmlTextField(false);
			addChild(enemiesTextfield);
			
			enemiesTextfield.x = 200;
			enemiesTextfield.y = 20;
			
			
			
			scoresTextfield = TextFieldFactory.createHtmlTextField(false);
			addChild(scoresTextfield);
			
			scoresTextfield.x = 330;
			scoresTextfield.y = 40;
			
			
			
			
			levelTextfield = TextFieldFactory.createHtmlTextField(false);
			addChild(levelTextfield);
			
			levelTextfield.x = 330;
			levelTextfield.y = 0;
			
			
			
			
			lifesTextfield = TextFieldFactory.createHtmlTextField(false);
			addChild(lifesTextfield);
			
			lifesTextfield.x = 730;
			lifesTextfield.y = 20;
			
			
			enemies = 0;
			lifes = 0;
			score = 0;
			level = 0;
		}
		
		public function set enemies(value:int):void
		{
			enemiesTextfield.htmlText = "<body>" + "= " + String(value) + "</body>";
		}
		
		public function set score(value:int):void
		{
			scoresTextfield.htmlText = "<body>" + "SCORE: <span class='yellow'>" + String(value) + "</span></body>";
		}
		
		public function set lifes(value:int):void
		{
			lifesTextfield.htmlText = "<body>" + "= " + String(value) + "</body>";
		}


		public function set level(value : int) : void
		{
			if(texts.length <=  value) return;
			
			levelTextfield.htmlText = "<body><span class='size25'><span class='center'>" + "Level " + String(value) + " : " + texts[value] + "</span></span></body>";
			
			levelTextfield.x = (width - levelTextfield.width >> 1) + 10;
		}
	}
}
