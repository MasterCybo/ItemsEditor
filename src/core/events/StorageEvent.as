package core.events
{
	import flash.events.Event;
	
	public class StorageEvent extends Event
	{
		public static const UPDATED_STORAGE:String = "updatedStorage";
		
		public function StorageEvent(type:String)
		{
			super(type, false, false);
		}
		
		override public function clone():Event
		{
			return new StorageEvent(type);
		}
	}
}
