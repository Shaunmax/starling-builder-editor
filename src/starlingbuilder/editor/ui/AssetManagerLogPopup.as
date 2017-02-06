/**
 * Created by hyh on 2/5/17.
 */
package starlingbuilder.editor.ui
{
    import feathers.controls.LayoutGroup;
    import feathers.controls.TextArea;
    import starlingbuilder.editor.UIEditorApp;
    import starlingbuilder.util.LogAssetManager;

    import starlingbuilder.util.feathers.popup.InfoPopup;

    public class AssetManagerLogPopup extends InfoPopup
    {
        public function AssetManagerLogPopup()
        {
            super();

            title = "AssetManager logs";
            buttons = ["OK"];
        }

        override protected function createContent(container:LayoutGroup):void
        {
            var assetManager:LogAssetManager = UIEditorApp.instance.assetManager as LogAssetManager;

            var text:TextArea = new TextArea();
            text.width = 600;
            text.height = 600;
            text.text = assetManager.logs.join("\n");
            container.addChild(text);
        }


    }
}
