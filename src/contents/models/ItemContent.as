package contents.models
{
	import contents.events.ItemContentEvent;
	
	import core.serialize.ISerializer;
	
	import flash.events.EventDispatcher;
	
	public class ItemContent extends EventDispatcher implements IContentItem
	{
		private static var _serializer:ISerializer;
		public static function config(serializer:ISerializer):void {_serializer = serializer;}
		public static function get serializer():ISerializer {return _serializer;}
		
		private var _itemID:String = "";
		private var _amount:Number = 0;
		
		public function ItemContent(itemID:String = "", amount:Number = 0)
		{
			super();
			_itemID = itemID;
			_amount = amount;
		}
		
		public function get itemID():String {return _itemID;}
		public function set itemID(value:String):void
		{
			if (value == _itemID) return;
			_itemID = value;
			dispatchEvent(new ItemContentEvent(ItemContentEvent.CHANGED_ITEM_ID));
		}
		
		public function get amount():Number {return _amount;}
		public function set amount(value:Number):void
		{
			if (value == _amount) return;
			_amount = value;
			dispatchEvent(new ItemContentEvent(ItemContentEvent.CHANGED_AMOUNT));
		}
		
		public function serialize():Object {return _serializer.serialize(this);}
	}
}
