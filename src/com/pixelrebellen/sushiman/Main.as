package com.pixelrebellen.sushiman
{
	import flash.events.MouseEvent;
	import com.pixelrebellen.core.text.TextFieldFactory;
	import com.pixelrebellen.core.utils.SpriteFactory;
	import com.pixelrebellen.sushiman.game.Game;
	import com.pixelrebellen.sushiman.game.events.GameModelEvent;
	import com.pixelrebellen.sushiman.game.models.GameModel;
	import com.pixelrebellen.sushiman.hud.GameOverPopupScreen;
	import com.pixelrebellen.sushiman.hud.Hud;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.StyleSheet;

	
	
	[SWF(backgroundColor="#FFFFFF", frameRate="25", width="855", height="685")]
    [Frame(factoryClass="com.pixelrebellen.sushiman.preloaders.PreloaderFactory")]
	public class Main extends Sprite
	{
		
		[Embed(source="/css/main.css", mimeType="application/octet-stream")] // NO PMD
        private var MainStyleSheet : Class;
		
		private var background:Sprite;
		
		private var game:Game;
		private var hud:Hud;
		private var gameOverPopupScreen:GameOverPopupScreen;
		
		public function Main()
		{
			var styleSheet : StyleSheet = new StyleSheet();
            styleSheet.parseCSS(new MainStyleSheet());
            TextFieldFactory.styleSheet = styleSheet;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedTostage);
        }

        private function onAddedTostage(event : Event) : void
        {
        	removeEventListener(Event.ADDED_TO_STAGE, onAddedTostage);
        	
			background = SpriteFactory.createRectBorderSprite(855, 685, 1, 0x5B1009);
			addChild(background);
			
			hud = new Hud();
			game = new Game();
			gameOverPopupScreen = new GameOverPopupScreen();


        	addChild(game);
			addChild(hud);
			addChild(gameOverPopupScreen);
			
			hud.x = background.width  - hud.width  >> 1;
			hud.y = background.height - hud.height;
			
			gameOverPopupScreen.x = background.width  - gameOverPopupScreen.width  >> 1;
			gameOverPopupScreen.y = background.height - gameOverPopupScreen.height >> 1;
			
			gameOverPopupScreen.visible = false;
			gameOverPopupScreen.continueButton.addEventListener(MouseEvent.CLICK, onContinueGame);
			
			game.addEventListener(GameModelEvent.UPDATE, onGameModelUpdate);
			game.addEventListener(GameModelEvent.GAME_OVER, onGameOver);
		}

		private function onContinueGame(event : MouseEvent) : void
		{
			game.start();
		}

		private function onGameOver(event : GameModelEvent) : void
		{
			gameOverPopupScreen.visible = true;
		}

		private function onGameModelUpdate(event : GameModelEvent) : void
		{
			var model:GameModel = event.model;
			
			hud.level = model.level;
			hud.score = model.score;
			hud.lifes = model.lifes;
			hud.enemies = model.enemies;
		}

	}
}
