/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package starlingbuilder.editor.ui
{
    import feathers.controls.LayoutGroup;
    import feathers.controls.TextArea;

    import flash.utils.getDefinitionByName;

    import starling.events.Event;

    import starlingbuilder.engine.format.StableJSONEncoder;

    public class DataProviderPopup extends AbstractPropertyPopup
    {
        protected var _textArea:TextArea;

        public function DataProviderPopup(owner:Object, target:Object, targetParam:Object, customParam:Object, onComplete:Function)
        {
            super(owner, target, targetParam, customParam, onComplete);

            title = "Edit Data";
            buttons = ["OK", "Cancel"];

            addEventListener(Event.COMPLETE, onDialogComplete);
        }

        override protected function createContent(container:LayoutGroup):void
        {
            _textArea = new TextArea();
            addChild(_textArea);

            if (_customParam && _customParam.params && _targetParam.name in _customParam.params)
            {
                _textArea.text = StableJSONEncoder.stringify(_customParam.params[_targetParam.name].data);
            }
        }

        protected function onDialogComplete(event:Event):void
        {
            var index:int = int(event.data);

            if (index == 0)
            {
                if (_textArea.text == "")
                {
                    _target = null;
                    setCustomParam(null);
                }
                else
                {
                    var obj:Object = JSON.parse(_textArea.text);

                    _target = createData(obj);
                    setCustomParam(obj);
                }

                complete();
            }
            else
            {
                _owner[_targetParam.name] = _oldTarget;
                _onComplete = null;
            }
        }

        protected function setCustomParam(obj:Object):void
        {
            if (_customParam)
            {
                if (_customParam.params == undefined)
                {
                    _customParam.params = {};
                }

                if (obj)
                {
                    _customParam.params[_targetParam.name] =
                    {
                        cls:getClsName(),
                        data: obj
                    };
                }
                else
                {
                    delete _customParam.params[_targetParam.name];
                }
            }
        }

        protected function complete():void
        {
            _onComplete(_target);
        }

        protected function createData(data:Object):Object
        {
            var cls:Class = getDefinitionByName(getClsName()) as Class;
            return new cls(data);
        }

        protected function getClsName():String
        {
            return _targetParam.cls;
        }
    }
}
