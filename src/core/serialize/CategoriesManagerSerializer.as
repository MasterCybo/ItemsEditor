package core.serialize
{
	import categories.models.MoCategory;
	
	public class CategoriesManagerSerializer implements ISerializer
	{
		public function CategoriesManagerSerializer()
		{
		}
		
		public function serialize(entity:*):Object
		{
			var result:Array = [];
			
			var categories:Vector.<MoCategory> = entity as Vector.<MoCategory>;
			var len:int = categories.length;
			for (var i:int = 0; i < len; i++) {
				result.push(categories[i].serialize());
			}
			
			return result;
		}
		
		public function deserialize(data:Object):*
		{
			return undefined;
		}
	}
}
