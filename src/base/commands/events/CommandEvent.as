package base.commands.events
{
	import flash.events.Event;
	
	public class CommandEvent extends Event
	{
		public static const COMPLETE:String = "completeCommand";
		
		private var _data:*;
		
		public function CommandEvent(type:String, data:* = null)
		{
			_data = data;
			super(type);
		}
		
		public function get data():* { return _data; }
	}
}
