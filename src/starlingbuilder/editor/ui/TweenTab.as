/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package starlingbuilder.editor.ui
{
    import flash.utils.Dictionary;

    import feathers.controls.Button;
    import feathers.controls.Check;
    import feathers.controls.LayoutGroup;
    import feathers.controls.ScrollContainer;
    import feathers.core.PopUpManager;
    import feathers.layout.VerticalLayout;

    import starling.display.DisplayObject;
    import starling.events.Event;

    import starlingbuilder.editor.UIEditorApp;
    import starlingbuilder.editor.controller.DocumentManager;
    import starlingbuilder.editor.data.TemplateData;
    import starlingbuilder.editor.events.DocumentEventType;
    import starlingbuilder.engine.util.ParamUtil;
    import starlingbuilder.util.feathers.FeathersUIUtil;
    import starlingbuilder.util.ui.inspector.PropertyPanel;

    public class TweenTab extends ScrollContainer
    {
        public static const TWEEN_DATA:String="tweenData";

        private var _propertiesPanel:PropertyPanel;
        private var _tweenAllCheck:Check;

        private var _documentManager:DocumentManager;

        private var _params:Array;

        private var _tweenSettingBtn:Button;
        /**tween 面板设置*/
        private var _tweenSettingListPanel:TweenSettingListPanel;

        public function TweenTab()
        {
            _params=ParamUtil.getTweenParams(TemplateData.editor_template);

            _documentManager=UIEditorApp.instance.documentManager;
            _documentManager.addEventListener(DocumentEventType.CHANGE, onChange);

            width=360;

            var layout:VerticalLayout=new VerticalLayout();
            layout.paddingTop=layout.gap=20;
            this.layout=layout;

            layoutData=FeathersUIUtil.anchorLayoutData(60, 0);

            initUI();
        }

        private function initUI():void
        {
            _propertiesPanel=new PropertyPanel({}, []);

            addChild(_propertiesPanel);

            _tweenAllCheck=new Check();
            _tweenAllCheck.label="tween all";
            _tweenAllCheck.isSelected=true;
            addChild(_tweenAllCheck);

            var group:LayoutGroup=FeathersUIUtil.layoutGroupWithHorizontalLayout();
            var playButton:Button=FeathersUIUtil.buttonWithLabel("start", onPlay);
            var stopButton:Button=FeathersUIUtil.buttonWithLabel("stop", onStop);
            group.addChild(playButton);
            group.addChild(stopButton);
            addChild(group);

            _tweenSettingBtn=FeathersUIUtil.buttonWithLabel("tween property editor", onOpenSetting);
            _tweenSettingBtn.isEnabled=false;
            addChild(_tweenSettingBtn);
        }

        private function onChange(event:Event):void
        {
            var obj:DisplayObject = _documentManager.singleSelectedObject;

            if (obj)
            {
                var target:Object=_documentManager.extraParamsDict[obj];

                _propertiesPanel.reloadData(target, _params);

                _tweenSettingBtn.isEnabled=true;
            }
            else
            {
                _propertiesPanel.reloadData();

                _tweenSettingBtn.isEnabled=false;
            }
        }

        private function findName(root:DisplayObject, object:DisplayObject, paramsDict:Dictionary):String
        {
            var name:String="";

            while (object !== root)
            {
                if (object == null)
                    return null;

                if (paramsDict[object])
                    name=object.name + "." + name;

                object=object.parent;
            }

            return name.substring(0, name.length - 1);
        }

        private function onPlay(event:*):void
        {
            var root:DisplayObject=_documentManager.root;
            var selected:DisplayObject=_documentManager.singleSelectedObject;
            var paramsDict:Dictionary=_documentManager.extraParamsDict;
            var names:Array;

            _documentManager.uiBuilder.tweenBuilder.stop(root, paramsDict);

            if (!_tweenAllCheck.isSelected)
            {
                var name:String=findName(root, selected, paramsDict);
                if (name)
                    names=[name];
            }

            _documentManager.uiBuilder.tweenBuilder.start(root, paramsDict, names);
        }

        private function onStop(event:*):void
        {
            var root:DisplayObject=_documentManager.root;
            var paramsDict:Dictionary=_documentManager.extraParamsDict;
            _documentManager.uiBuilder.tweenBuilder.stop(root);
        }

        private function onOpenSetting():void
        {
            var target:Object=_documentManager.extraParamsDict[_documentManager.singleSelectedObject];
            _tweenSettingListPanel=new TweenSettingListPanel(target["tweenData"]);
            PopUpManager.addPopUp(_tweenSettingListPanel);
            _tweenSettingListPanel.onComplete=onComplete;
            function onComplete(resultObj:Object):void
            {
                trace("result= \n" + resultObj);
                if (resultObj == null)
                    delete target["tweenData"];
                else
                    target["tweenData"]=resultObj;
                _propertiesPanel.reloadData(target, _params);
            }
        }

        override public function dispose():void
        {
            super.dispose();
        }
    }
}
