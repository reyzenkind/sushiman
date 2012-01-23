package com.pixelrebellen.sushiman.hud.fonts
{
	import flash.display.Sprite;
	import flash.text.Font;
	import flash.utils.describeType;

	public class FontEmbedder extends Sprite
	{        
		// Latin I ; Uppercase [A..Z] ; Lowercase [a..z] ; Numerals [0..9] ; Punctuation [!@#%...] ; Basic Latin 
        [Embed(source="/fonts/ShowcardGothic.ttf", mimeType="application/x-font-truetype", fontName="ShowcardGothic-Regular",  unicodeRange="U+00A0,U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+00A1-U+00FF,U+02C6,U+02DC,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183,U+2026,U+201E,U+201C", embedAsCFF="false")] 
        public var font1:Class;
        
		public function FontEmbedder()
		{
//			Security.allowDomain("*");
			var xml:XML = describeType(this);
			var varXMLList:XMLList = xml['variable'];
			for (var i:uint = 0; i < varXMLList.length(); i++)
			{
				Font.registerFont(this[varXMLList[i].@name]);
			}
		}
	}
}