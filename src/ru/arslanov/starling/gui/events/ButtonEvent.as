package ru.arslanov.starling.gui.events
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class ButtonEvent extends Event
	{
		public static const RELEASE:String = "release";
		
		public function ButtonEvent(type:String, data:Object = null)
		{
			super(type, true, data);
		}
		
		public override function toString():String
		{
			return "[ButtonEvent, type:" + type + ", bubbles:" + bubbles + "]";
		}
		
	}
	
}