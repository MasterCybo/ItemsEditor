package categories.events
{
	import categories.models.MoCategory;
	
	import flash.events.Event;
	
	public class CategoriesManagerEvent extends Event
	{
		public static const ADDED_CATEGORY:String = "addedCategory";
		public static const REMOVED_CATEGORY:String = "removedCategory";
		public static const UPDATED_ALL:String = "updatedAllCategories";
		
		private var _category:MoCategory;
		
		public function CategoriesManagerEvent(type:String, category:MoCategory = null)
		{
			_category = category;
			super(type, false, false);
		}
		
		public function get category():MoCategory {return _category;}
	}
}
