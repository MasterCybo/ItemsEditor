/**
 * Copyright (c) 2015 Artem Arslanov. All rights reserved.
 */
package ru.arslanov.core.advert
{
	import flash.events.Event;
	
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class AdAdapterEvent extends Event
	{
		public static const DISPLAY_INTERSTITIAL:String = "displayInterstitial"; // Перед показом рекламной вставки
		public static const CLICKED_INTERSTITIAL:String = "clickedInterstitial"; // При клике по рекламной вставке
		public static const CLOSED_INTERSTITIAL:String = "closedInterstitial"; // При закрытии рекалмной вставки
		public static const ERROR_INTERSTITIAL:String = "failLoadingInterstitial"; // При ошибке загрузки рекламной вставки

		private var _message:String;

		public function AdAdapterEvent(type:String, message:String = "", bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_message = message;
			super(type, bubbles, cancelable);
		}

		public function get message():String { return _message; }
		
		public override function clone():Event
		{
			return new AdAdapterEvent(type, message, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("AdAdapterEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}