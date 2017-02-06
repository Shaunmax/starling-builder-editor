/**
 * Created by hyh on 2/5/17.
 */
package starlingbuilder.util
{
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    /**
     * Use for detecting crash caused by loading conflicting swf library
     *
     * When a crash happens there's no way to catch any errors.
     * So we call mark() to write a file into the file system and delete it by calling clearMark afterwards.
     * If the file is detected we can assume a crash happens on the last run between mark() and clearMark() is called.
     */
    public class WatchDog
    {
        private var _file:File;

        public function WatchDog(file:File)
        {
            _file = file;
        }

        public function mark():void
        {
            if (!_file.exists)
            {
                var fs:FileStream = new FileStream();
                fs.open(_file, FileMode.WRITE);
                fs.writeUTFBytes(new Date().toString());
                fs.close();
            }
        }

        public function clearMark():void
        {
            if (_file.exists)
                _file.deleteFile();
        }

        public function get cleared():Boolean
        {
            return !_file.exists;
        }
    }
}
