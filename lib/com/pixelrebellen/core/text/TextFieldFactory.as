/*
 * Copyright 2009 - 2010 Netzbewegung GmbH
 * All Rights Reserved.
 * 
 * NOTICE: Netzbewegung GmbH permits you to use, modify, and distribute this 
 * file in accordance with the terms of the license agreement accompanying it.
 *
 * Created by Gunnar Herzog <g.herzog[at]netzbewegung.com> . 
 */
package com.pixelrebellen.core.text 
{
	import flash.errors.IllegalOperationError;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	public class TextFieldFactory 
	{
		private static var _styleSheet : StyleSheet;

		public static function convertToStyledInputField(tf : TextField, styleNames : Array) : void
		{
			tf.styleSheet = null;
			tf.embedFonts = true;
			tf.defaultTextFormat = getTextFormatFor(styleNames);
			tf.type = TextFieldType.INPUT;
			tf.selectable = true;
		}

		
		public static function convertToStyledStaticTextField(tf : TextField) : void
		{
			tf.embedFonts = true;
			tf.type = TextFieldType.DYNAMIC;
			tf.selectable = false;
			tf.styleSheet = _styleSheet;//getTextFormatFor(styleNames);
			
			// the text has to be inserted again
			if(tf.htmlText != "")
				tf.htmlText = "<html>" + tf.htmlText + "</html>";
		}

		
		public static function createInputTextField(styleNames : Array, width : Number, height : Number) : TextField
		{
			var textField : TextField = new TextField();
			textField.autoSize = TextFieldAutoSize.NONE;			
			textField.width = width;
			textField.height = height;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			textField.gridFitType = GridFitType.PIXEL;
			textField.embedFonts = true;
			textField.type = TextFieldType.INPUT;
			textField.selectable = true;
			textField.defaultTextFormat = getTextFormatFor(styleNames);
			return textField;
		}

		
		public static function createHtmlTextField(multiline : Boolean = true, width : int = 100) : HtmlTextField
		{
			if(_styleSheet == null)
				throw new IllegalOperationError("No style sheet specified in TextFieldFactory.STYLE_SHEET");

			var textField : HtmlTextField = new HtmlTextField();
			textField.width = width;
			textField.styleSheet = _styleSheet;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			textField.gridFitType = GridFitType.PIXEL;
			textField.embedFonts = true;
			textField.autoSize = multiline ? TextFieldAutoSize.CENTER : TextFieldAutoSize.LEFT;
			textField.multiline = multiline;
			textField.wordWrap = multiline;
			textField.selectable = false;
			textField.condenseWhite = true;
			textField.mouseWheelEnabled = false;
			return textField;
		}

		
		public static function createNonStyledTextField(multiline : Boolean = true, width : int = 100) : TextField
		{
			var textField : TextField = new TextField();
			textField.width = width;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			textField.gridFitType = GridFitType.PIXEL;
			textField.embedFonts = true;
			textField.autoSize = multiline ? TextFieldAutoSize.CENTER : TextFieldAutoSize.LEFT;
			textField.multiline = multiline;
			textField.wordWrap = multiline;
			textField.selectable = false;
			textField.condenseWhite = true;
			return textField;
		}

		
		public static function getTextFormatFor(styleNames : Array) : TextFormat 
		{
			if(_styleSheet == null)
				throw new IllegalOperationError("No style sheet specified in TextFieldFactory.STYLE_SHEET");
			
			if(styleNames.indexOf("html") == -1)
			{
				styleNames.unshift("html");
			}
			
			var mergedStyle : Object = new Object(); // NO PMD
			for (var i : int = 0;i < styleNames.length;++i)
			{
				var o : Object = _styleSheet.getStyle(styleNames[i]); // NO PMD
				for (var key : String in o)
				{
					mergedStyle[key] = o[key];
				}
			}
			
			return(_styleSheet.transform(mergedStyle));
        }
        
        
        static public function get styleSheet () : StyleSheet
        {
            return _styleSheet;
        }
        
        
        static public function set styleSheet (styleSheet : StyleSheet) : void
        {
            _styleSheet = styleSheet;
        }
    }
}
