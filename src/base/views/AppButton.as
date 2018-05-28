package base.views
{
	import feathers.controls.Button;
	
	import starling.events.Event;
	
	public class AppButton extends Button
	{
		public var bubblingEvents:Boolean = true;
		
		public function AppButton(label:String = null, name:String = null)
		{
			super();
			if (label) this.label = label;
			if (name) this.name = name;
			addEventListener(Event.TRIGGERED, triggeredHandler);
		}
		
		override public function dispose():void
		{
			removeEventListener(Event.TRIGGERED, triggeredHandler);
			super.dispose();
		}
		
		private function triggeredHandler(event:Event):void
		{
			event.stopImmediatePropagation();
			event.stopPropagation();
			
			removeEventListener(event.type, triggeredHandler);
			
			dispatchEventWith(event.type, bubblingEvents);
			
			addEventListener(event.type, triggeredHandler);
		}
	}
}
