package com.pixelrebellen.sushiman.hud
{
	import com.greensock.TweenMax;
	import com.pixelrebellen.core.text.HtmlTextField;
	import com.pixelrebellen.core.text.TextFieldFactory;
	import com.pixelrebellen.core.utils.SpriteFactory;
	import com.pixelrebellen.sushiman.assets.LogoAsset;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author JESSA
	 */
	public class GameOverPopupScreen extends Sprite
	{
		private var bg:Sprite;
		
		private var headerTextfield:HtmlTextField;
		private var textTextfield:HtmlTextField;
		private var iamTextfield:HtmlTextField;
		private var forTextfield:HtmlTextField;
		
		public var continueButton:Sprite; 
		
		
		private var logo:LogoAsset;
		
		public function GameOverPopupScreen()
		{
			bg = SpriteFactory.createRectSprite(500, 200, 1,  0xffffff);
			addChild(bg);
			
			headerTextfield = TextFieldFactory.createHtmlTextField(false);
			addChild(headerTextfield);
			
			headerTextfield.htmlText = "<body><span class='gold'><span class='size26'>" + "Thanks for playing Suchiman" + "</span></span></body>";
			
			headerTextfield.x = bg.width  - headerTextfield.width  >> 1;
			headerTextfield.y = 10;
			
			textTextfield = TextFieldFactory.createHtmlTextField(false);
			addChild(textTextfield);
			
			textTextfield.htmlText = "<body><span class='red'><span class='size26'>" + "Play again" + "</span></span></body>";
			
			textTextfield.x = bg.width  - textTextfield.width  >> 1;
			textTextfield.y = 50;
			
			
			
			iamTextfield = TextFieldFactory.createHtmlTextField(true, 400);
			addChild(iamTextfield);
			
			iamTextfield.htmlText = "<body><span class='gold'><span class='size14'><span class='center'>" + "Eugen Reyzenkind (eugen.reyzenkind@web.de)" + "</span></span></span></body>";
			
			iamTextfield.x = bg.width  - iamTextfield.width  >> 1;
			iamTextfield.y = 80;
			
			forTextfield = TextFieldFactory.createHtmlTextField(true, 400);
			addChild(forTextfield);
			
			forTextfield.htmlText = "<body><span class='gold'><span class='size14'><span class='center'>" + "for" + "</span></span></span></body>";
			
			forTextfield.x = bg.width  - forTextfield.width  >> 1;
			forTextfield.y = 100;
			
			logo = new LogoAsset();
			addChild(logo);
			
			logo.x = bg.width  - logo.width  >> 1;
			logo.y = (bg.height  - logo.height  >> 1) + 60;
			
			
			
			continueButton = SpriteFactory.createRectSprite(textTextfield.width, textTextfield.height);
			addChild(continueButton);
			
			continueButton.x = textTextfield.x;
			continueButton.y = textTextfield.y;
			
			continueButton.buttonMode = true;
			continueButton.mouseChildren = false;
			
			continueButton.addEventListener(MouseEvent.ROLL_OVER, onOver);
			continueButton.addEventListener(MouseEvent.ROLL_OUT, onOut);
			
			continueButton.addEventListener(MouseEvent.CLICK, onClick);
		}

		private function onClick(event : MouseEvent) : void
		{
			visible = false;
		}

		private function onOut(event : MouseEvent) : void
		{
			TweenMax.to(textTextfield, 0.5, {alpha:1});
		}

		private function onOver(event : MouseEvent) : void
		{
			TweenMax.to(textTextfield, 0.5, {alpha:0.6});
		}
	}
}
