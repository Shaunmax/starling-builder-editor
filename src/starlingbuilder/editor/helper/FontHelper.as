/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package starlingbuilder.editor.helper
{
    import flash.text.Font;
    import flash.utils.Dictionary;

    import starling.core.Starling;

    public class FontHelper
    {
        // the name container with the registered bitmap fonts
        private static const BITMAP_FONT_DATA_NAME:String = "starling.display.TextField.BitmapFonts";

        public static function getFontNames():Array
        {
            var array:Array = [];

            var dict:Dictionary = Starling.current.contextData[BITMAP_FONT_DATA_NAME] as Dictionary;

            for (var name:String in dict)
            {
                array.push(name);
            }

            var fonts:Array = Font.enumerateFonts();

            for each (var font:Font in fonts)
            {
                if (array.indexOf(font.fontName) == -1)
                    array.push(font.fontName);
            }

            array.sort(Array.CASEINSENSITIVE);

            return array;
        }
    }
}
