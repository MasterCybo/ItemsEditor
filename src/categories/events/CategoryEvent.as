package categories.events
{
	import categories.models.MoCategory;
	
	import flash.events.Event;
	
	public class CategoryEvent extends Event
	{
		public static const SELECTED:String = "selectedCategory";
		public static const CHANGED_NAME:String = "nameChange";
		public static const CHANGED_CONTENTS_TYPE:String = "changedContentsType";
		
		private var _category:MoCategory;
		
		public function CategoryEvent(type:String, category:MoCategory = null)
		{
			_category = category;
			super(type, false, false);
		}
		
		public function get category():MoCategory {return _category;}
	}
}
