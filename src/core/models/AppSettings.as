package core.models
{
	import flash.net.SharedObject;
	
	public class AppSettings
	{
		private static var _instance:AppSettings;
		
		public function AppSettings(key:SingletonKey)
		{
		}
		
		public static function get me():AppSettings
		{
			if (!_instance) _instance = new AppSettings(new SingletonKey());
			return _instance;
		}
		
		
		public var lastFile:String;
		public var lastPath:String;
		public var atlasFile:String;
		
		private var _sharedObject:SharedObject;
		
		public function load():void
		{
			readSharedObject();
			lastPath = _sharedObject.data.lastPath;
		}
		
		public function save():void
		{
			readSharedObject();
			_sharedObject.data.lastFile = lastFile;
			_sharedObject.data.lastPath = lastPath;
			_sharedObject.flush();
			
			trace("Saved settings...");
			trace("\tPath : " + lastPath);
			trace("\tFile : " + lastFile);
		}
		
		public function readSharedObject():void
		{
			if (_sharedObject) return;
			_sharedObject = SharedObject.getLocal("settings");
		}
	}
}

internal class SingletonKey {}
