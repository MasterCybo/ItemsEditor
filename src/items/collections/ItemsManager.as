package items.collections
{
	import categories.models.MoCategory;
	
	import core.serialize.ISerializer;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import items.events.ItemsManagerEvent;
	import items.filters.IItemsFilter;
	import items.models.MoItem;
	
	public class ItemsManager extends EventDispatcher
	{
		private static var _serializer:ISerializer;
		public static function config(serializer:ISerializer):void {_serializer = serializer;}
		public static function get serializer():ISerializer {return _serializer;}
		
		
		private var _items:Vector.<MoItem> = new Vector.<MoItem>();
		private var _itemsMap:Object = {};
		private var _categoryMap:Dictionary = new Dictionary(); // MoCategory = Vector.<MoItem>
		
		private var _lastID:int = 0;
		
		public function ItemsManager()
		{
			super();
		}
		
		public function serialize():Object {return serializer.serialize(_items);}
		
		public function removeAll():void
		{
			_items = new Vector.<MoItem>();
			_itemsMap = {};
			_categoryMap = new Dictionary();
			_lastID = 0;
			dispatchEvent(new ItemsManagerEvent(ItemsManagerEvent.UPDATE_ALL));
		}
		
		public function get items():Vector.<MoItem> {return _items.concat();}
		
		public function getItems(itemsFilter:IItemsFilter):Vector.<MoItem>
		{
			return itemsFilter ? items.filter(itemsFilter.filter) : items;
		}

		public function getItem(id:String):MoItem {return _itemsMap[id];}
		
		public function hasItem(item:MoItem):Boolean {return _itemsMap[item.id] != undefined;}
		
		public function getItemsFor(category:MoCategory):Vector.<MoItem> {return _categoryMap[category];}
		public function getNumItemsFor(category:MoCategory):int
		{
			var items:Vector.<MoItem> = getItemsFor(category);
			return items ? items.length : 0;
		}
		
		public function addItems(items:Vector.<MoItem>):void
		{
			if (!items) return;
			
			for (var i:int = 0; i < items.length; i++) {
				internalAddItem(items[i]);
			}
			
			dispatchEvent(new ItemsManagerEvent(ItemsManagerEvent.UPDATE_ALL));
		}
		
		public function addItem(item:MoItem):void
		{
			if (hasItem(item)) return;
			
			internalAddItem(item);
			
			dispatchEvent(new ItemsManagerEvent(ItemsManagerEvent.ADDED_ITEM, item));
		}
		
		private function internalAddItem(item:MoItem):void
		{
			var itemID:Number = item.id ? parseFloat(item.id) : NaN;
			
			if (!isNaN(itemID)) {
				_lastID = Math.max(_lastID, itemID);
			}
			
			item.id = String(_lastID);
			
			_lastID++;
			
			_items.push(item);
			_itemsMap[item.id] = item;
			
			var categoryItems:Vector.<MoItem> = _categoryMap[item.category];
			if (!categoryItems) {
				categoryItems = new Vector.<MoItem>();
				_categoryMap[item.category] = categoryItems;
			}
			
			categoryItems.push(item);
		}
		
		public function removeItem(item:MoItem):void
		{
			if (!hasItem(item)) return;
			
			internalRemoveItem(item);
			
			dispatchEvent(new ItemsManagerEvent(ItemsManagerEvent.REMOVED_ITEM, item));
		}
		
		public function removeItems(items:Vector.<MoItem>):void
		{
			if (!items) return;
			
			for (var i:int = items.length - 1; i >= 0; i--) {
				internalRemoveItem(items[i]);
			}
			
			dispatchEvent(new ItemsManagerEvent(ItemsManagerEvent.UPDATE_ALL));
		}
		
		private function internalRemoveItem(item:MoItem):void
		{
			var idx:int = _items.indexOf(item);
			
			if (idx != -1) {
				_items.splice(idx, 1);
				delete _itemsMap[item.id];
				
				var categoryItems:Vector.<MoItem> = _categoryMap[item.category];
				if (categoryItems) {
					idx = categoryItems.indexOf(item);
					if (idx != -1) categoryItems.splice(idx, 1);
				}
				
				if (categoryItems.length == 0) {
					delete _categoryMap[item.category];
				}
			}
		}
	}
}
