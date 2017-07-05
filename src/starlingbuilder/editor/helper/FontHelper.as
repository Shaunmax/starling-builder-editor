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
    import flash.text.FontType;
    import flash.utils.Dictionary;

    import starling.core.Starling;

    public class FontHelper
    {
        // the name container with the registered bitmap fonts
        private static const BITMAP_FONT_DATA_NAME:String = "starling.display.TextField.compositors";

        public static function getFontNames():Array
        {
            var array:Array = [];

            var dict:Dictionary = Starling.painter.sharedData[BITMAP_FONT_DATA_NAME] as Dictionary;

            for (var name:String in dict)
            {
                array.push(name);
            }

            var fonts:Array = Font.enumerateFonts();

            for each (var font:Font in fonts)
            {
                //skip cff font since Starling TextField does not support it
                if (font.fontType == FontType.EMBEDDED_CFF)
                    continue;

                if (array.indexOf(font.fontName) == -1)
                    array.push(font.fontName);
            }

            array.sort(Array.CASEINSENSITIVE);

            return array;
        }
    }
}
