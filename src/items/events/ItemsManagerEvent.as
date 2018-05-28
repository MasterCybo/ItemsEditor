package items.events
{
	import flash.events.Event;
	
	import items.models.MoItem;
	
	public class ItemsManagerEvent extends Event
	{
		public static const ADDED_ITEM:String = "addedItem";
		public static const REMOVED_ITEM:String = "removedItem";
		public static const UPDATE_ALL:String = "updateAllItems";
		
		private var _item:MoItem;
		
		public function ItemsManagerEvent(type:String, category:MoItem = null)
		{
			_item = category;
			super(type, false, false);
		}
		
		public function get item():MoItem {return _item;}
	}
}
