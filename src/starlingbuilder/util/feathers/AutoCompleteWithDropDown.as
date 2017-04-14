/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package starlingbuilder.util.feathers
{
    import feathers.controls.AutoComplete;
    import feathers.data.ListCollection;
    import feathers.events.FeathersEventType;

    import flash.utils.getTimer;

    import flash.utils.setTimeout;

    import starling.events.Event;

    public class AutoCompleteWithDropDown extends AutoComplete
    {
        public function AutoCompleteWithDropDown()
        {
            super();
        }

        public function set autoCompleteSource(data:Array):void
        {
            var listCollection:ListCollection = new ListCollection();

            for each (var item:Object in data)
            {
                listCollection.push(item);
            }

            source = new LocalAutoCompleteSourceWithDropDown(listCollection);
            minimumAutoCompleteLength = 0;
            autoCompleteDelay = 0;
            addEventListener(FeathersEventType.FOCUS_IN, onFocusIn);
        }

        private function onFocusIn(event:Event):void
        {
            if(this._autoCompleteDelay == 0)
            {
                //just in case the enter frame listener was added before
                //sourceUpdateDelay was set to 0.
                this.removeEventListener(Event.ENTER_FRAME, autoComplete_enterFrameHandler);

                this._source.load(this.text, this._listCollection);
            }
            else
            {
                this._lastChangeTime = getTimer();
                this.addEventListener(Event.ENTER_FRAME, autoComplete_enterFrameHandler);
            }
        }

        override public function dispose():void
        {
            removeEventListener(FeathersEventType.FOCUS_IN, onFocusIn);
            super.dispose();
        }
    }
}
