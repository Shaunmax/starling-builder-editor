/**
 * Created by hyh on 2/5/17.
 */
package starlingbuilder.util
{
    import starling.utils.AssetManager;

    public class LogAssetManager extends AssetManager
    {
        private var _logs:Array = [];

        public function LogAssetManager(scaleFactor:Number = 1, useMipmaps:Boolean = false)
        {
            super(scaleFactor, useMipmaps);
        }

        override protected function log(message:String):void
        {
            _logs.push(message);
            super.log(message);
        }

        public function get logs():Array
        {
            return _logs;
        }
    }
}
