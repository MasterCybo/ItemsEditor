package core.serialize
{
	import contents.models.EffectContent;
	import contents.models.IContentItem;
	import contents.models.ItemContent;
	
	public class ContentsSerializer implements ISerializer
	{
		private static var _serializer:ISerializer;
		public static function config(serializer:ISerializer):void {_serializer = serializer;}
		public static function get serializer():ISerializer {return _serializer;}
		
		public function ContentsSerializer()
		{
		}
		
		public function serialize(list:*):Object
		{
			var contents:Vector.<IContentItem> = Vector.<IContentItem>(list);
			var result:Array = [];
			
			var len:int = contents.length;
			var contentItem:IContentItem;
			var contData:Object;
			for (var i:int = 0; i < len; i++) {
				contentItem = contents[ i ];
				contData = contentItem.serialize();
				result.push(contData);
			}
			
			return result;
		}
		
		public function deserialize(data:Object):*
		{
			var contents:Vector.<IContentItem> = new Vector.<IContentItem>();
			
			if (data) {
				var contentsData:Array = data as Array;
				var len:int = contentsData.length;
				var contData:Object;
				for (var i:int = 0; i < len; i++) {
					contData = contentsData[ i ];
					if (contData.hasOwnProperty("itemID")) {
						contents.push(ItemContent.serializer.deserialize(contData));
					} else {
						contents.push(EffectContent.serializer.deserialize(contData));
					}
				}
			}
			
			return contents;
		}
	}
}
