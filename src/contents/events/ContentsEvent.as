package contents.events
{
	import contents.models.IContentItem;
	
	import flash.events.Event;
	
	public class ContentsEvent extends Event
	{
		public static const ADDED_CONTENT:String = "addedContent";
		public static const REMOVED_CONTENT:String = "removedContent";
		public static const UPDATE_CONTENT:String = "updateContent";
		
		private var _content:IContentItem;
		
		public function ContentsEvent(type:String, content:IContentItem = null)
		{
			_content = content;
			super(type, false, false);
		}
		
		public function get content():IContentItem {return _content;}
	}
}
