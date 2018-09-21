package core.serialize
{
	import categories.models.MoCategory;
	
	import core.models.DataStore;
	
	import items.models.MoItem;
	
	public class DataStoreSerializer implements ISerializer
	{
		public function DataStoreSerializer()
		{
		}
		
		public function serialize(entity:*):Object
		{
			var result:Object = {};
			
			var store:DataStore = entity as DataStore;
			if (store) {
				result["categories"] = store.categoriesManager.serialize();
				result["items"] = store.itemsManager.serialize();
			}
			
			return result;
		}
		
		public function deserialize(data:Object):*
		{
			if (!data) return;
			
			var categoriesData:Array = data["categories"];
			var itemsData:Array = data["items"];
			
			var i:int;
			
			var categoryTypes:Vector.<MoCategory> = new Vector.<MoCategory>();
			var len:int = categoriesData.length;
			for (i = 0; i < len; i++) {
				categoryTypes.push(MoCategory.serializer.deserialize(categoriesData[i]));
			}
			
			DataStore.me.categoriesManager.removeAll();
			DataStore.me.categoriesManager.addCategories(categoryTypes);
			
			var items:Vector.<MoItem> = new Vector.<MoItem>();
			len = itemsData.length;
			for (i = 0; i < len; i++) {
				items.push(MoItem.serializer.deserialize(itemsData[i]));
			}
			
			DataStore.me.itemsManager.removeAll();
			DataStore.me.itemsManager.addItems(items);
			
			return null;
		}
	}
}
