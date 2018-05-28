package items.events
{
	import flash.events.Event;
	
	import items.models.MoItem;
	
	public class ItemListEvent extends Event
	{
		public static const SELECTED_ITEM:String = "selectedItem";
		
		private var _item:MoItem;
		
		public function ItemListEvent(type:String, category:MoItem = null)
		{
			_item = category;
			super(type, false, false);
		}
		
		public function get item():MoItem {return _item;}
	}
}
