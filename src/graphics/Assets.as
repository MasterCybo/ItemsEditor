package graphics
{
	import starling.utils.AssetManager;
	
	public class Assets extends AssetManager
	{
		private static var _instance:Assets;
		
		public function Assets(key:SingletonKey)
		{
		}
		
		public static function get me():Assets
		{
			if (!_instance) _instance = new Assets(new SingletonKey());
			return _instance;
		}
		
	}
}

internal class SingletonKey {}