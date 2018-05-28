package items.events
{
	import flash.events.Event;
	
	public class ItemPropertyEvent extends Event
	{
		public static const CHANGED_VALUE:String = "changedValue";
		
		private var _property:String;
		private var _value:*;
		
		public function ItemPropertyEvent(type:String, property:String, value:*)
		{
			super(type, false, false);
			_property = property;
			_value = value;
		}
		
		public function get property():String {return _property;}
		public function get value():* {return _value;}
		
		override public function clone():Event
		{
			return new ItemPropertyEvent(type, _property, _value);
		}
	}
}
