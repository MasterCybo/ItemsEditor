package ru.arslanov.starling.mvc.mediators
{
	/**
	 * Интерфейс медиатора
	 * @author Artem Arslanov
	 */
	public interface IMediator
	{
		function initialize(displayObject:Object):void;
		function destroy():void;
		
		function getView():Object;
	}
	
}