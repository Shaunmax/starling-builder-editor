/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package starlingbuilder.editor.ui
{
    import feathers.core.PopUpManager;

    import flash.geom.Point;

    import starlingbuilder.editor.SupportedWidget;
    import starlingbuilder.editor.UIEditorApp;
    import starlingbuilder.editor.UIEditorScreen;
    import starlingbuilder.editor.controller.DocumentManager;
    import starlingbuilder.editor.data.TemplateData;
    import starlingbuilder.editor.helper.UIComponentHelper;
    import starlingbuilder.engine.util.ParamUtil;
    import starlingbuilder.util.feathers.FeathersUIUtil;
    import starlingbuilder.util.ui.list.ExpandableGroupedList;

    import feathers.controls.Button;
    import feathers.controls.ButtonGroup;
    import feathers.controls.GroupedList;
    import feathers.controls.Label;
    import feathers.controls.LayoutGroup;
    import feathers.controls.List;
    import feathers.controls.PickerList;
    import feathers.controls.TextInput;
    import feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer;
    import feathers.controls.renderers.IGroupedListItemRenderer;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.HierarchicalCollection;
    import feathers.data.ListCollection;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;
    import feathers.layout.HorizontalLayout;
    import feathers.layout.VerticalLayout;

    import flash.filesystem.File;
    import flash.utils.Dictionary;

    import starling.display.DisplayObject;

    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.utils.AssetManager;

    import starling.textures.TextureAtlas;

    public class AssetTab extends SearchableTab
    {
        private static const linker:Array = [DefaultCreateComponentPopup, DefaultEditPropertyPopup, ImageGridPopup, TexturePropertyPopup, DisplayObjectPropertyPopup, TextureConstructorPopup,
            ObjectPropertyPopup, XmlPropertyPopup, ListCollectionPopup, HierarchicalCollectionPopup];

        public static var assetList:Vector.<String>;

        private var _assetManager:AssetManager;

        private var _documentManager:DocumentManager;

        private var _list:ExpandableGroupedList;

        private var _typePicker:PickerList;

        private var _supportedTypes:Array;

        private var _bottomContainer:LayoutGroup;

        public function AssetTab()
        {
            _assetManager = UIEditorApp.instance.assetManager;

            _documentManager = UIEditorApp.instance.documentManager;

            var anchorLayoutData:AnchorLayoutData = new AnchorLayoutData();
            anchorLayoutData.top = 25;
            anchorLayoutData.bottom = 0;
            this.layoutData = anchorLayoutData;

            layout = new AnchorLayout();

            createSupportedTypes();

            createTopContainer();

            createBottomContainer();

            listAssets();
        }

        override protected function createTopContainer():void
        {
            super.createTopContainer();

            createBrowseButton();
            createLogButton();
        }

        private function createBottomContainer():void
        {
            _bottomContainer = FeathersUIUtil.layoutGroupWithVerticalLayout();

            var anchorLayoutData:AnchorLayoutData = new AnchorLayoutData();
            anchorLayoutData.bottom = 0;
            _bottomContainer.layoutData = anchorLayoutData;

            addChild(_bottomContainer);

            createListButtons(_bottomContainer);

            createPickerList(_bottomContainer);
        }

        private function createSupportedTypes():void
        {
            _supportedTypes = TemplateData.getSupportedComponent("asset");
        }

        private function createBrowseButton():void
        {
            _topContainer.addChild(FeathersUIUtil.buttonWithLabel("browse", function():void{

                var file:File = UIEditorScreen.instance.workspaceDir.resolvePath("textures");

                if (file)
                {
                    file.openWithDefaultApplication();
                }

            }));
        }

        private function createLogButton():void
        {
            _topContainer.addChild(FeathersUIUtil.buttonWithLabel("log", function():void{

                PopUpManager.addPopUp(new  AssetManagerLogPopup());

            }));
        }

        private function onListChange(event:Event):void
        {
            if (_list.selectedItem)
            {
                create(_list.selectedItem.label);

                _list.setSelectedLocation(-1, -1);
            }
        }

        public function create(label:String, position:Point = null):void
        {
            var editorData:Object = {name:label, textureName:label};
            editorData.cls = _supportedTypes[_typePicker.selectedIndex];

            if (position)
            {
                editorData.x = position.x;
                editorData.y = position.y;
            }

            UIComponentHelper.createComponent(editorData);
        }

        private function listAssets():void
        {
            _list = new ExpandableGroupedList();
            _list.isFocusEnabled = false;
            _list.width = 330;
            _list.height = 800;
            _list.setSelectedLocation(-1, -1);
            _list.itemRendererFactory = function():IGroupedListItemRenderer
            {
                return new GroupedListIconItemRenderer();
            }

            var anchorLayoutData:AnchorLayoutData = new AnchorLayoutData();
            anchorLayoutData.top = 0;
            anchorLayoutData.bottom = 0;
            anchorLayoutData.topAnchorDisplayObject = _topContainer;
            anchorLayoutData.bottomAnchorDisplayObject = _bottomContainer;
            _list.layoutData = anchorLayoutData;

            refreshAsset();

            _list.addEventListener(Event.CHANGE, onListChange);
            addChild(_list);
        }

        private function getTextureNames():Vector.<String>
        {
            var array:Vector.<String> = _assetManager.getTextureNames();

            for (var i:int = array.length - 1; i >= 0; --i)
            {
                var name:String = array[i];

                if (_assetManager.getTextureAtlas(name) || TextField.getBitmapFont(name))
                {
                    array.splice(i, 1);
                }
            }

            return array;
        }

        private function getGroupAssets():HierarchicalCollection
        {
            var atlasNames:Vector.<String> = _assetManager.getTextureAtlasNames();
            var atlasName:String;

            var data:Array = [];
            var item:Object;

            var atlas:TextureAtlas;

            var itemDict:Dictionary = new Dictionary();

            for each (atlasName in atlasNames)
            {
                atlas = _assetManager.getTextureAtlas(atlasName);

                item = {header:{label:atlasName}, children:[]};
                data.push(item);
                itemDict[atlasName] = item;
            }

            var array:Vector.<String> = filterList(_searchTextInput.text.toLowerCase(), assetList);

            var found:Boolean;

            var others:Object = {header:{label:"-others-"}, children:[]};
            data.push(others);

            for each (var name:String in array)
            {
                for each (atlasName in atlasNames)
                {
                    found = false;

                    atlas = _assetManager.getTextureAtlas(atlasName);
                    if (atlas.getTexture(name))
                    {
                        itemDict[atlasName].children.push({label:name});
                        found = true;
                        break;
                    }
                }

                if (!found)
                {
                    others.children.push({label:name});
                }
            }

            for (var i:int = data.length - 1; i >= 0; --i)
            {
                item = data[i];
                if (item.children.length == 0)
                    data.splice(i, 1);
            }

            return new HierarchicalCollection(data);
        }

        private function refreshList():void
        {
            _list.dataProvider = getGroupAssets();
        }

        private function filterList(text:String, array:Vector.<String>):Vector.<String>
        {
            if (text.length)
            {
                array = array.filter(function(value:String, index:int, arr:Vector.<String>):Boolean{
                    return value.toLowerCase().indexOf(text) != -1;
                });
            }

            return array;
        }

        private function createToolButtons(buttons:Array, anchorDisplayObject:DisplayObject = null):ButtonGroup
        {
            var group:ButtonGroup = new ButtonGroup();
            group.paddingTop = 5;
            group.paddingBottom = 5;
            group.direction = ButtonGroup.DIRECTION_HORIZONTAL;
            group.width = 280;
            group.dataProvider = new ListCollection(buttons);

            var layoutData:AnchorLayoutData = new AnchorLayoutData();
            layoutData.left = 0;
            layoutData.right = 0;
            layoutData.bottom = 0;

            if (anchorDisplayObject)
            {
                layoutData.bottomAnchorDisplayObject = anchorDisplayObject;
            }

            group.layoutData = layoutData;

            addChild(group);

            return group;
        }

        private function createTextButtons():Array
        {
            return [
                {label:"collapse all", triggered:onCollapseButton},
                {label:"expand all", triggered:onExpandButton},
            ];
        }

        private function createListButtons(container:Sprite):void
        {
            container.addChild(createToolButtons(createTextButtons()));
        }

        private function onExpandButton(event:Event):void
        {
            _list.expandAll();
        }

        private function onCollapseButton(event:Event):void
        {
            _list.collapseAll();
        }

        private function createPickerList(container:Sprite):void
        {
            _typePicker = new PickerList();

            _typePicker.dataProvider = new ListCollection(_supportedTypes);
            _typePicker.selectedIndex = 0;

            var anchorLayoutData:AnchorLayoutData = new AnchorLayoutData();
            anchorLayoutData.bottom = 0;
            _typePicker.layoutData = anchorLayoutData;

            container.addChild(_typePicker);
        }

        private function onCreateButton(event:Event):void
        {
            var cls:String = _supportedTypes[_typePicker.selectedIndex];

            var name:String = ParamUtil.getDisplayObjectName(cls);

            var editorData:Object = {name:name, textureName:name, cls:cls};
            UIComponentHelper.createComponent(editorData);
        }

        override protected function onSearch(event:Event):void
        {
            refreshList();
        }

        public function refreshAsset():void
        {
            assetList = getTextureNames();
            refreshList();
        }
    }
}
