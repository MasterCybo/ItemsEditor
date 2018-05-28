package core.serialize
{
	import contents.models.EffectContent;
	
	public class EffectContentSerializer implements ISerializer
	{
		public function EffectContentSerializer()
		{
		}
		
		public function serialize(entity:*):Object
		{
			var itemContent:EffectContent = EffectContent(entity);
			var result:Object =  {
				property:itemContent.property,
				additive:itemContent.additive
			};
			
			return result;
		}
		
		public function deserialize(data:Object):*
		{
			var result:EffectContent = new EffectContent(data["property"], data["additive"]);
			return result;
		}
	}
}
