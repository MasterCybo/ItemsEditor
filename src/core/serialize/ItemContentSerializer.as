package core.serialize
{
	import contents.models.ItemContent;
	
	public class ItemContentSerializer implements ISerializer
	{
		public function ItemContentSerializer()
		{
		}
		
		public function serialize(entity:*):Object
		{
			var itemContent:ItemContent = ItemContent(entity);
			var result:Object =  {
				itemID:itemContent.itemID,
				amount:itemContent.amount
			};
			
			return result;
		}
		
		public function deserialize(data:Object):*
		{
			var result:ItemContent = new ItemContent(data["itemID"], data["amount"]);
			return result;
		}
	}
}
