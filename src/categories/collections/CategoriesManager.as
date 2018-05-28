package categories.collections
{
	import categories.events.CategoriesManagerEvent;
	import categories.models.MoCategory;
	
	import core.serialize.ISerializer;
	
	import flash.events.EventDispatcher;
	
	public class CategoriesManager extends EventDispatcher
	{
		private static var _serializer:ISerializer;
		public static function config(serializer:ISerializer):void {_serializer = serializer;}
		public static function get serializer():ISerializer {return _serializer;}
		
		
		private var _categories:Vector.<MoCategory> = new Vector.<MoCategory>();
		private var _categoriesMap:Object = {}; // value = MoCategory
		
		public function CategoriesManager()
		{
			super();
		}
		
		public function serialize():Object {return serializer.serialize(_categories);}
		
		public function removeAll():void
		{
			_categories = new Vector.<MoCategory>();
			_categoriesMap = {};
			dispatchEvent(new CategoriesManagerEvent(CategoriesManagerEvent.UPDATED_ALL));
		}
		
		public function get categories():Vector.<MoCategory> {return _categories.concat();}
		
		public function hasCategory(category:MoCategory):Boolean
		{
			return category ? _categoriesMap[category.name] != undefined : false;
		}
		
		public function getCategory(value:String):MoCategory {return _categoriesMap[value];}
		
		public function addCategories(categories:Vector.<MoCategory>):void
		{
			for (var i:int = 0; i < categories.length; i++) {
				 internalAddCategory(categories[i]);
			}
			dispatchEvent(new CategoriesManagerEvent(CategoriesManagerEvent.UPDATED_ALL));
		}
		
		public function addCategory(category:MoCategory):void
		{
			if (hasCategory(category)) return;
			internalAddCategory(category);
			dispatchEvent(new CategoriesManagerEvent(CategoriesManagerEvent.ADDED_CATEGORY, category));
		}
		
		private function internalAddCategory(category:MoCategory):void
		{
			_categories.push(category);
			_categoriesMap[category.name] = category;
		}
		
		public function removeCategory(category:MoCategory):void
		{
			if (!hasCategory(category)) return;
			
			var idx:int = -1;
			var currentType:MoCategory;
			for (var i:int = 0; i < _categories.length; i++) {
				currentType = _categories[ i ];
				if (currentType.equals(category)) {
					idx = i;
					break;
				}
			}
			
			if (idx != -1) _categories.splice(idx, 1);
			delete _categoriesMap[category.name];
			
			dispatchEvent(new CategoriesManagerEvent(CategoriesManagerEvent.REMOVED_CATEGORY, category));
		}
	}
}
