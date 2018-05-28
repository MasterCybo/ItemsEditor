package items.events
{
	import starling.events.Event;
	
	public class ListItemRendererEvent extends Event
	{
		public static const CHANGED_DATA:String = "changedData";
		
		public function ListItemRendererEvent(type:String, bubbling:Boolean = false)
		{
			super(type, bubbling);
		}
	}
}
