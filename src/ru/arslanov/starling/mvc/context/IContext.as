/**
 * Copyright (c) 2015 SmartHead. All rights reserved.
 */
package ru.arslanov.starling.mvc.context
{
	import flash.events.IEventDispatcher;
	
	import ru.arslanov.starling.mvc.commands.ICommandMap;
	import ru.arslanov.starling.mvc.injection.IInjector;
	import ru.arslanov.starling.mvc.mediators.IMediatorMap;
	
	/**
	 * Интерфейс контекста
	 * @author Artem Arslanov
	 */
	public interface IContext extends IEventDispatcher
	{
		function get contextView():Object;
		function get injector():IInjector;
		function get mediatorMap():IMediatorMap;
		function get commandMap():ICommandMap;
		
		function install(...extensionClasses):IContext;
		function configure(...configClasses):IContext;
	}
}
