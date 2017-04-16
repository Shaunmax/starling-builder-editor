/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package starlingbuilder.editor.helper
{
    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class SelectHelper
    {
        private static var _triggered:Boolean;

        public static function setup():void
        {
            Starling.current.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame)
        }

        private static function onEnterFrame(event:Event):void
        {
            _triggered = false;
        }

        public static function startSelect(object:DisplayObject, onSelect:Function):void
        {
            function onTouch(event:TouchEvent):void
            {
                if (_triggered) return;

                var touch:Touch = event.getTouch(object);

                if (touch)
                {
                    if (touch.phase == TouchPhase.BEGAN)
                    {
                        onSelect(object);
                    }
                }

                _triggered = true;
            }

            object.addEventListener(TouchEvent.TOUCH, onTouch);
        }

        public static function endSelect(obj:DisplayObject):void
        {
            obj.removeEventListeners(TouchEvent.TOUCH);
        }
    }
}
