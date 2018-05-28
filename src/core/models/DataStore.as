package core.models
{
	import categories.collections.CategoriesManager;
	
	import core.serialize.ISerializer;
	
	import flash.events.EventDispatcher;
	
	import items.collections.ItemsManager;
	
	public class DataStore extends EventDispatcher
	{
		private static var _instance:DataStore;
		
		public function DataStore(key:SingletonKey)
		{
		}
		
		public static function get me():DataStore
		{
			if (!_instance) _instance = new DataStore(new SingletonKey());
			return _instance;
		}
		
		private static var _serializer:ISerializer;
		public static function config(serializer:ISerializer):void {_serializer = serializer;}
		public static function get serializer():ISerializer {return _serializer;}
		
		
		private var _itemsManager:ItemsManager = new ItemsManager();
		private var _categoriesManager:CategoriesManager = new CategoriesManager();
		
		public function serialize():Object {return serializer.serialize(this);}
		
		public function get itemsManager():ItemsManager {return _itemsManager;}
		public function get categoriesManager():CategoriesManager {return _categoriesManager;}
		
		public function get isDirty():Boolean
		{
			return _itemsManager.items.length != 0 || _categoriesManager.categories.length != 0;
		}
	}
}

internal class SingletonKey {}