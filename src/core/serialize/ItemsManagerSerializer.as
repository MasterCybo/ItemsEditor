package core.serialize
{
	import items.models.MoItem;
	
	public class ItemsManagerSerializer implements ISerializer
	{
		public function ItemsManagerSerializer()
		{
		}
		
		public function serialize(entity:*):Object
		{
			var result:Array = [];
			
			var items:Vector.<MoItem> = entity as Vector.<MoItem>;
			var len:int = items.length;
			for (var i:int = 0; i < len; i++) {
				result.push(items[i].serialize());
			}
			
			return result;
		}
		
		public function deserialize(data:Object):*
		{
			var result:Vector.<MoItem> = new Vector.<MoItem>();
			
			var itemsData:Array = data as Array;
			var len:int = itemsData.length;
			var itemData:Object;
			for (var i:int = 0; i < len; i++) {
				itemData = itemsData[ i ];
				result.push(MoItem.serializer.deserialize(itemsData));
			}
			
			return result;
		}
	}
}
