/**
 * Created by hyh on 2/20/17.
 */
package starlingbuilder.editor.ui
{
    import feathers.controls.LayoutGroup;
    import feathers.controls.TextInput;

    import starling.events.Event;

    import starlingbuilder.util.feathers.FeathersUIUtil;

    public class SearchableTab extends LayoutGroup
    {
        protected var _topContainer:LayoutGroup;
        protected var _searchTextInput:TextInput;

        public function SearchableTab()
        {
            super();
        }

        protected function createTopContainer():void
        {
            _topContainer = FeathersUIUtil.layoutGroupWithHorizontalLayout();
            addChild(_topContainer);

            createSearchTextInput();
        }

        private function createSearchTextInput():void
        {
            _searchTextInput = new TextInput();
            _searchTextInput.prompt = "Search...";
            _searchTextInput.addEventListener(Event.CHANGE, onSearch);
            _topContainer.addChild(_searchTextInput);
        }

        protected function onSearch(event:Event):void
        {
        }
    }
}
