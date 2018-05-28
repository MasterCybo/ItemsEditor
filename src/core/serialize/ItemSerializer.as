package core.serialize
{
	import core.models.DataStore;
	
	import items.collections.ItemPropertyEnum;
	import items.models.MoItem;
	
	import ru.arslanov.core.enum.Enum;
	
	import contents.models.EffectContent;
	
	public class ItemSerializer implements ISerializer
	{
		public function ItemSerializer()
		{
		}
		
		public function serialize(entity:*):Object
		{
			var item:MoItem = entity as MoItem;
			var result:Object = {};
			
			var properties:Vector.<ItemPropertyEnum> = item.properties;
			var len:int = properties.length;
			var property:ItemPropertyEnum;
			for (var i:int = 0; i < len; i++) {
				property = properties[ i ];
				result[property.getString()] = item.getValue(property);
			}
			
			result["category"] = item.category.name;
			result["contents"] = ContentsSerializer.serializer.serialize(item.contents);
			
			return result;
		}
		
		public function deserialize(data:Object):*
		{
			var item:MoItem = new MoItem();
			
			var propertyNames:Vector.<String> = item.propertyNames;
			var len:int = propertyNames.length;
			var property:ItemPropertyEnum;
			var propName:String;
			for (var i:int = 0; i < len; i++) {
				propName = propertyNames[ i ];
				property = Enum.getElementByValue(propName, ItemPropertyEnum) as ItemPropertyEnum;
				item.setValue(property, data[propName]);
			}
			
			item.category = DataStore.me.categoriesManager.getCategory(data["category"]);
			
			if (data["stuffing"]) {
				item.contents = ContentsSerializer.serializer.deserialize(data["stuffing"]);
			} else {
				item.contents = ContentsSerializer.serializer.deserialize(data["contents"]);
			}
			
			return item;
		}
	}
}
