package contents.events
{
	import flash.events.Event;
	
	public class ItemContentEvent extends Event
	{
		public static const CHANGED_AMOUNT:String = "changedAmountEvent";
		public static const CHANGED_ITEM_ID:String = "changedItemIDEvent";
		
		public function ItemContentEvent(type:String)
		{
			super(type);
		}
	}
}
