/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package starlingbuilder.editor.helper
{
    import starling.display.DisplayObject;

    public class PixelSnapperData
    {
        public var selectObjs:Array;
        public var targetObjX:DisplayObject;
        public var targetObjY:DisplayObject;

        public var selectObjSnapXType:int;
        public var selectObjSnapYType:int;

        public var targetObjSnapXType:int;
        public var targetObjSnapYType:int;

        public var deltaX:Number;
        public var deltaY:Number;

        public function PixelSnapperData(selectObjs:Array, targetObjX:DisplayObject, targetObjY:DisplayObject,
                                         selectObjSnapXType:int, selectObjSnapYType:int, targetObjSnapXType:int, targetObjSnapYType:int,
                                         deltaX:Number, deltaY:Number)
        {
            this.selectObjs = selectObjs;
            this.targetObjX = targetObjX;
            this.targetObjY = targetObjY;
            this.selectObjSnapXType = selectObjSnapXType;
            this.selectObjSnapYType = selectObjSnapYType;
            this.targetObjSnapXType = targetObjSnapXType;
            this.targetObjSnapYType = targetObjSnapYType;
            this.deltaX = deltaX;
            this.deltaY = deltaY;
        }
    }
}
