package properties.events
{
	import starling.events.Event;
	
	public class PropertyEditorEvent extends Event
	{
		public static const CHANGED_VALUE:String = "changedValue";
		
		private var _property:String;
		private var _value:*;
		
		public function PropertyEditorEvent(type:String, property:String, value:*)
		{
			super(type, true);
			_property = property;
			_value = value;
		}
		
		public function get property():String {return _property;}
		public function get value():* {return _value;}
	}
}
