package base.views
{
	import feathers.controls.List;
	
	import starling.events.Event;
	
	public class AppList extends List
	{
		public function AppList()
		{
			super();
			addEventListener(Event.CHANGE, eventHandler);
			addEventListener(Event.TRIGGERED, eventHandler);
		}
		
		override public function dispose():void
		{
			removeEventListener(Event.CHANGE, eventHandler);
			removeEventListener(Event.TRIGGERED, eventHandler);
			super.dispose();
		}
		
		private function eventHandler(event:Event):void
		{
			event.stopImmediatePropagation();
			event.stopPropagation();
			
			removeEventListener(event.type, eventHandler);
			
			dispatchEventWith(event.type, true);
			
			addEventListener(event.type, eventHandler);
		}
	}
}
