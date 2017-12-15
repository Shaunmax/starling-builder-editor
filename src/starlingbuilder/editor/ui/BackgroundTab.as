/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package starlingbuilder.editor.ui
{
    import feathers.controls.ButtonGroup;
    import feathers.controls.TextInput;
    import feathers.layout.Direction;

    import flash.geom.Rectangle;

    import starling.display.DisplayObject;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;

    import starlingbuilder.editor.UIEditorApp;
    import starlingbuilder.editor.UIEditorScreen;
    import starlingbuilder.editor.controller.DocumentManager;
    import starlingbuilder.editor.data.TemplateData;
    import starlingbuilder.editor.events.DocumentEventType;
    import starlingbuilder.editor.helper.FileListingHelper;
    import starlingbuilder.util.ui.inspector.PropertyPanel;

    import feathers.controls.Button;
    import feathers.controls.LayoutGroup;
    import feathers.controls.List;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import org.as3commons.lang.ObjectUtils;

    import starling.display.Image;
    import starling.events.Event;
    import starling.utils.AssetManager;

    public class BackgroundTab extends SearchableTab
    {
        private var _assetManager:AssetManager;
        private var _documentManager:DocumentManager;

        private var _list:List;

        private var _buttonGroup:ButtonGroup;

        private var _propertyPanel:PropertyPanel;

        private var _template:Object;

        private var _params:Array;

        public function BackgroundTab()
        {
            _assetManager = UIEditorApp.instance.assetManager;
            _documentManager = UIEditorApp.instance.documentManager;
            _documentManager.addEventListener(DocumentEventType.CHANGE, onChange);

            _template = TemplateData.editor_template;

            var anchorLayoutData:AnchorLayoutData = new AnchorLayoutData();
            anchorLayoutData.top = 25;
            anchorLayoutData.bottom = 0;
            this.layoutData = anchorLayoutData;

            layout = new AnchorLayout();

            createResetButton();

            createPropertyPanel();

            createTopContainer();

            listAssets();
        }

        override protected function feathersControl_addedToStageHandler(event:Event):void
        {
            super.feathersControl_addedToStageHandler(event);

            UIEditorApp.instance.documentManager.setChanged();
        }

        private function onListChange(event:Event):void
        {
            if (_list.selectedIndex != -1)
            {
                createComponent(_list.selectedItem.label);
                _list.selectedIndex = -1;
            }
        }

        private function createPropertyPanel():void
        {
            _propertyPanel = new PropertyPanel(null, null);
            var anchorLayoutData:AnchorLayoutData = new AnchorLayoutData();
            anchorLayoutData.bottom = 10;
            anchorLayoutData.left = anchorLayoutData.right = 5;
            anchorLayoutData.bottomAnchorDisplayObject = _buttonGroup;
            _propertyPanel.layoutData = anchorLayoutData;

            addChild(_propertyPanel);
        }

        private function createResetButton():void
        {
            _buttonGroup = new ButtonGroup();
            _buttonGroup.direction = Direction.HORIZONTAL;
            _buttonGroup.dataProvider = new ListCollection([
                {label:"reset", triggered:onButton},
                {label:"fit", triggered:onButton}
            ]);

            var anchorLayoutData:AnchorLayoutData = new AnchorLayoutData();
            anchorLayoutData.bottom = 0;
            _buttonGroup.layoutData = anchorLayoutData;

            addChild(_buttonGroup);
        }

        private function onButton(event:Event):void
        {
            var button:Button = event.target as Button;
            switch (button.label)
            {
                case "reset":
                    _documentManager.background = null;
                    _documentManager.setChanged();
                    break;
                case "fit":
                    if (_documentManager.background)
                    {
                        fitBackground(_documentManager.background, _documentManager.container);
                        _documentManager.setChanged();
                    }
                    break;
            }
        }

        private function listAssets():void
        {
            _list = new List();
            _list.isFocusEnabled = false;
            _list.width = 330;
            _list.height = 800;
            _list.selectedIndex = -1;
            _list.itemRendererFactory = function():IListItemRenderer
            {
                return new IconItemRenderer();
            }

            _list.addEventListener(Event.CHANGE, onListChange);

            var anchorLayoutData:AnchorLayoutData = new AnchorLayoutData();
            anchorLayoutData.top = 0;
            anchorLayoutData.bottom = 10;
            anchorLayoutData.bottomAnchorDisplayObject = _propertyPanel;
            anchorLayoutData.topAnchorDisplayObject = _searchTextInput;
            _list.layoutData = anchorLayoutData;

            addChild(_list);

            updateData();
        }

        private function createComponent(name:String):void
        {
            var image:Image = new Image(_assetManager.getTexture(name));
            image.name = name;
            _documentManager.background = image;
            _documentManager.setChanged();
        }

        private function onChange(event:Event):void
        {
            if (!_params)
            {
                _params = ObjectUtils.clone(_template.background.params);
            }

            if (_documentManager.background)
            {
                _propertyPanel.reloadData(_documentManager.background, _params);
            }
            else
            {
                _propertyPanel.reloadData();
            }
        }

        public static function fitBackground(object:DisplayObject, canvas:DisplayObject):void
        {
            var objectRect:Rectangle = new Rectangle(0, 0, object.width, object.height);
            var canvasRect:Rectangle = new Rectangle(0, 0, canvas.width, canvas.height);
            var rect:Rectangle = RectangleUtil.fit(objectRect, canvasRect, ScaleMode.NO_BORDER);
            object.x = rect.x;
            object.y = rect.y;
            object.width = rect.width;
            object.height = rect.height;
        }

        private function updateData():void
        {
            var array:Array = FileListingHelper.getFileList(UIEditorScreen.instance.workspaceDir, UIEditorScreen.instance.workspaceSetting.backgroundPath, ["png", "jpg", "atf"]);

            var data:ListCollection = new ListCollection();

            var searchText:String = _searchTextInput.text.toLowerCase();

            for each (var name:String in array)
            {
                if (searchText == "" || name.toLowerCase().indexOf(searchText) != -1)
                    data.push({label:name});
            }

            _list.dataProvider = data;
        }

        override protected function onSearch(event:Event):void
        {
            updateData();
        }
    }
}
