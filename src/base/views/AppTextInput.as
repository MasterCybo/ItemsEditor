package base.views
{
	import feathers.controls.TextInput;
	import feathers.events.FeathersEventType;
	
	import starling.events.Event;
	
	public class AppTextInput extends TextInput implements ITextEditor
	{
		public var bubblingEvents:Boolean = true;
		
		public function AppTextInput(text:* = "")
		{
			super();
			this.text = text;
			
			addEventListener(Event.CHANGE, eventHandler);
			addEventListener(FeathersEventType.ENTER, eventHandler);
			addEventListener(FeathersEventType.FOCUS_IN, eventHandler);
			addEventListener(FeathersEventType.FOCUS_OUT, eventHandler);
		}
		
		override public function dispose():void
		{
			removeEventListener(Event.CHANGE, eventHandler);
			removeEventListener(FeathersEventType.ENTER, eventHandler);
			removeEventListener(FeathersEventType.FOCUS_IN, eventHandler);
			removeEventListener(FeathersEventType.FOCUS_OUT, eventHandler);
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
