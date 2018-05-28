/**
 * Created by Artem-Home on 13.02.2017.
 */
package ru.arslanov.starling.mvc.commands
{
	import flash.events.Event;
	
	public interface ICommandMap
	{
		function hasEventCommand(eventType:String, concreteCommand:Class = null):Boolean;
		function unmap(eventType:String, commandClass:Class = null):void;
		function map(eventType:String, eventClass:Class = null):ICommandSetter;
		function dispatchEvent(event:Event):Boolean;
	}
}
