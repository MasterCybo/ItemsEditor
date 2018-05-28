/**
 * Copyright (c) 2015 Artem Arslanov. All rights reserved.
 */
package ru.arslanov.starling.mvc.context
{
	import flash.events.Event;
	
	import ru.arslanov.starling.mvc.commands.ICommandMap;
	import ru.arslanov.starling.mvc.context.IContext;
	
	import ru.arslanov.starling.mvc.injection.IInjector;
	import ru.arslanov.starling.mvc.mediators.IMediatorMap;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public interface IObjectContext
	{
		function get context():IContext;
		function get injector():IInjector;
		function get mediatorMap():IMediatorMap;
		function get commandMap():ICommandMap;

		function destroy():void;
		
		function hasContextListener(type:String):Boolean;
		function willTrigger(type:String):Boolean;
		function addContextListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		function removeContextListener(type:String, listener:Function, useCapture:Boolean = false):void;
		function dispatchEvent(event:Event):Boolean;
		
	}
}
