/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package starlingbuilder.editor.ui
{
    import starling.animation.IAnimatable;

    import starlingbuilder.editor.UIEditorApp;
    import starlingbuilder.editor.controller.DocumentManager;
    import starlingbuilder.util.feathers.FeathersUIUtil;

    import feathers.controls.Button;
    import feathers.controls.LayoutGroup;

    import starling.core.Starling;

    import starling.display.MovieClip;
    import starling.events.Event;

    public class AnimatableTool extends LayoutGroup
    {
        private var _movieClipTool:LayoutGroup;
        private var _playButton:Button;
        private var _stopButton:Button;

        private var _documentManager:DocumentManager;

        public function AnimatableTool()
        {
            _documentManager = UIEditorApp.instance.documentManager;
            initMovieClipTool();
        }

        private function initMovieClipTool():void
        {
            _movieClipTool = FeathersUIUtil.layoutGroupWithHorizontalLayout();

            _playButton = FeathersUIUtil.buttonWithLabel("play", onPlayButton);
            _stopButton = FeathersUIUtil.buttonWithLabel("stop", onStopButton);

            _movieClipTool.addChild(FeathersUIUtil.labelWithText("IAnimatable: "))
            _movieClipTool.addChild(_playButton);
            _movieClipTool.addChild(_stopButton);

            addChild(_movieClipTool);
        }

        public function updateMovieClipTool():void
        {
            var animatable:IAnimatable = _documentManager.singleSelectedObject as IAnimatable;

            _movieClipTool.visible = (animatable != null);
        }

        private function onPlayButton(event:Event):void
        {
            var animatable:IAnimatable = _documentManager.singleSelectedObject as IAnimatable;

            if (animatable)
            {
                Starling.current.juggler.add(animatable);

                if (animatable is MovieClip)
                    (animatable as MovieClip).play();

                _documentManager.setChanged();
            }
        }

        private function onStopButton(event:Event):void
        {
            var animatable:IAnimatable = _documentManager.singleSelectedObject as IAnimatable;

            if (animatable)
            {
                if (animatable is MovieClip)
                    (animatable as MovieClip).stop();

                Starling.current.juggler.remove(animatable);
                _documentManager.setChanged();
            }
        }
    }
}
