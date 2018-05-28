package base.views
{
	import feathers.controls.PickerList;
	
	import starling.events.Event;
	
	public class AppPickerList extends PickerList
	{
		public var bubblingEvents:Boolean = true;
		
		public function AppPickerList()
		{
			super();
			addEventListener(Event.CHANGE, eventHandler);
		}
		
		override public function dispose():void
		{
			removeEventListener(Event.CHANGE, eventHandler);
			super.dispose();
		}
		
		private function eventHandler(event:Event):void
		{
			event.stopImmediatePropagation();
			event.stopPropagation();
			
			removeEventListener(event.type, eventHandler);
			
			dispatchEventWith(event.type, bubblingEvents);
			
			addEventListener(event.type, eventHandler);
		}
	}
}
