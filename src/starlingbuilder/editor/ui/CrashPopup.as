/**
 * Created by hyh on 2/5/17.
 */
package starlingbuilder.editor.ui
{
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import starling.events.Event;

    import starlingbuilder.util.feathers.popup.InfoPopup;

    public class CrashPopup extends InfoPopup
    {
        public static const CRASH_FAQ_URL:String = "http://wiki.starling-framework.org/builder/faq#the_editor_crashes_without_showing_any_errors";

        public function CrashPopup()
        {
            super();

            title = "A crash is detected.\nIt's most likely caused by conflict of library version between the editor and the extension swfs.\nClick OK to see more information";
            buttons = ["OK"];
            addEventListener(Event.COMPLETE, onComplete);
        }

        private function onComplete(event:Event):void
        {
            navigateToURL(new URLRequest(CRASH_FAQ_URL));
        }
    }
}
