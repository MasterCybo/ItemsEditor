package core.serialize
{
	import categories.models.MoCategory;
	
	import contents.collections.ContentsTypeEnum;
	
	import ru.aa.enums.Enum;
	
	public class CategoryTypeSerializer implements ISerializer
	{
		public function CategoryTypeSerializer()
		{
		}
		
		public function serialize(entity:*):Object
		{
			var result:Object = {
				name: MoCategory(entity).name,
				contentsType: MoCategory(entity).contentsType.getString()
			};
			
			return result;
		}
		
		public function deserialize(data:Object):*
		{
			var category:MoCategory = new MoCategory(data["name"]);
			
			var nameField:String;
			
			if (data.hasOwnProperty("stuffingType")) {
				nameField = "stuffingType";
			} else {
				nameField = "contentsType";
			}
			category.contentsType = Enum.getElementByValue(data[nameField], ContentsTypeEnum, ContentsTypeEnum.EFFECTS);
			
			return category;
		}
	}
}
