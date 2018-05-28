package ru.arslanov.starling.mvc.commands
{
	import flash.events.Event;
	
	import ru.arslanov.starling.mvc.injection.IInjector;
	import ru.arslanov.starling.mvc.mediators.IMediatorMap;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public interface ICommand
	{
		function execute():void;
		function destruct():void;
		function getEvent():Event;
		function get injector():IInjector;
		function get mediatorMap():IMediatorMap;
		function get commandMap():ICommandMap
		function dispatchEvent(event:Event):Boolean
	}
	
}