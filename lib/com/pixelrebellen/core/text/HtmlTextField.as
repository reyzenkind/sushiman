package com.pixelrebellen.core.text 
{
	import flash.text.TextField;

	public class HtmlTextField extends TextField 
	{
		override public function set htmlText(value : String) : void
		{
			super.htmlText = "<html>"+value+"</html>";
		}
	}
}
