/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package starlingbuilder.editor.ui
{
    import flash.geom.Point;

    import starlingbuilder.editor.UIEditorApp;
    import starlingbuilder.editor.data.TemplateData;
    import starlingbuilder.editor.helper.FontHelper;
    import starlingbuilder.editor.helper.UIComponentHelper;

    import feathers.controls.List;
    import feathers.controls.PickerList;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import starling.events.Event;
    import starling.utils.AssetManager;

    public class TextTab extends SearchableTab
    {
        public static const DEFAULT_TEXT:String = "Abc123";
        public static const DEFAULT_SIZE:int = 46;
        public static const DEFAULT_COLOR:uint = 0xffffff;

        private var _assetManager:AssetManager;

        private var _list:List;

        private var _typePicker:PickerList;

        private var _supportedTypes:Array;

        public function TextTab()
        {
            _assetManager = UIEditorApp.instance.assetManager;

            createPickerList();

            createTopContainer();


            var anchorLayoutData:AnchorLayoutData = new AnchorLayoutData();
            anchorLayoutData.top = 25;
            anchorLayoutData.bottom = 0;
            this.layoutData = anchorLayoutData;

            layout = new AnchorLayout();

            listAssets();
        }

        private function createPickerList():void
        {
            _typePicker = new PickerList();

            _supportedTypes = TemplateData.getSupportedComponent("text");

            _typePicker.dataProvider = new ListCollection(_supportedTypes);
            _typePicker.selectedIndex = 0;

            var anchorLayoutData:AnchorLayoutData = new AnchorLayoutData();
            anchorLayoutData.bottom = 0;
            _typePicker.layoutData = anchorLayoutData;

            addChild(_typePicker);
        }

        private function onListChange(event:Event):void
        {
            if (_list.selectedIndex != -1)
            {
                create(_list.selectedItem.label);

                _list.selectedIndex = -1;
            }
        }

        public function create(label:String, position:Point = null):void
        {
            var cls:String = _supportedTypes[_typePicker.selectedIndex];

            var editorData:Object = {cls:cls, font:label, name:label, text:DEFAULT_TEXT, size:DEFAULT_SIZE, color:DEFAULT_COLOR};

            if (position)
            {
                editorData.x = position.x;
                editorData.y = position.y;
            }

            UIComponentHelper.createComponent(editorData);
        }

        private function listAssets():void
        {
            _list = new List();
            _list.isFocusEnabled = false;
            _list.itemRendererFactory = function():IListItemRenderer
            {
                return new TextItemRenderer();
            }

            _list.width = 330;
            _list.height = 800;
            _list.selectedIndex = -1;
            _list.addEventListener(Event.CHANGE, onListChange);

            var anchorLayoutData:AnchorLayoutData = new AnchorLayoutData();
            anchorLayoutData.top = 0;
            anchorLayoutData.bottom = 0;
            anchorLayoutData.bottomAnchorDisplayObject = _typePicker;
            anchorLayoutData.topAnchorDisplayObject = _searchTextInput;
            _list.layoutData = anchorLayoutData;

            addChild(_list);

            updateData();
        }

        private function updateData():void
        {
            var fonts:Array = FontHelper.getBitmapFontNames();

            var data:ListCollection = new ListCollection();

            var searchText:String = _searchTextInput.text.toLowerCase();

            for each (var name:String in fonts)
            {
                if (searchText == "" || name.toLowerCase().indexOf(searchText) != -1)
                    data.push({label: name});
            }

            _list.dataProvider = data;
        }

        override protected function onSearch(event:Event):void
        {
            updateData();
        }
    }
}
