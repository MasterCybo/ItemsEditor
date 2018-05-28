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
	import ru.arslanov.starling.mvc.context.IObjectContext;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class ObjectContext implements IObjectContext
	{
		private var _context:IContext;

		public function ObjectContext(context:IContext)
		{
			_context = context;
		}

		public function destroy():void
		{
			_context = null;
		}

		public function get context():IContext { return _context; }
		public function get injector():IInjector { return _context.injector; }
		public function get mediatorMap():IMediatorMap { return _context.mediatorMap; }
		public function get commandMap():ICommandMap { return _context.commandMap; }
		
		/*
		 *	Events
		 */
		public function hasContextListener(type:String):Boolean { return _context.hasEventListener(type); }
		public function willTrigger(type:String):Boolean { return _context.willTrigger(type); }
		
		public function addContextListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_context.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeContextListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_context.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return _context.dispatchEvent(event);
		}
	}
}
