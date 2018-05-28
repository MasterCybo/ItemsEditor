package ru.arslanov.starling.mvc.events
{
	import flash.events.Event;
	
	public class ContextEvent extends Event
	{
		public static const CONTEXT_VIEW_ADDED:String = "contextViewAddedEvent";
		
		public function ContextEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
