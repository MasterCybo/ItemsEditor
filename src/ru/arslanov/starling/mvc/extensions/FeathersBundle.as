package ru.arslanov.starling.mvc.extensions
{
	import feathers.FEATHERS_VERSION;
	import feathers.core.FeathersControl;
	import feathers.events.FeathersEventType;
	
	import ru.arslanov.core.utils.Log;
	
	import ru.arslanov.starling.mvc.context.IContext;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class FeathersBundle extends StarlingBundle
	{
		public function FeathersBundle(context:IContext)
		{
			super(context);
			Log.traceText("VERSION Feathers " + FEATHERS_VERSION);
		}
		
		override protected function onAdded(event:Event):void
		{
			var displayObject:DisplayObject = event.target as DisplayObject;
			var feathersControl:FeathersControl = displayObject as FeathersControl;
			if (!feathersControl) {
				super.onAdded(event);
			} else {
				if (feathersControl.isInitialized) {
					super.onAdded(event);
				} else {
					feathersControl.addEventListener(FeathersEventType.INITIALIZE, onFeathersControlInitialized);
				}
			}
		}
		
		private function onFeathersControlInitialized(event:Event):void
		{
			var feathersControl:FeathersControl = event.target as FeathersControl;
			feathersControl.removeEventListener(FeathersEventType.INITIALIZE, onFeathersControlInitialized);
			super.onAdded(event);
		}
	}
}
