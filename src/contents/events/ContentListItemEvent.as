package contents.events
{
	import contents.models.IContentItem;
	
	import starling.events.Event;
	
	public class ContentListItemEvent extends Event
	{
		public static const TRIGGERED_REMOVE_BUTTON:String = "triggeredRemoveButton";
		
		private var _content:IContentItem;
		
		public function ContentListItemEvent(type:String, content:IContentItem, bubbles:Boolean = false)
		{
			_content = content;
			super(type, bubbles);
		}
		
		public function get content():IContentItem {return _content;}
	}
}
