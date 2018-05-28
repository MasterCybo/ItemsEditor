/**
 * Copyright (c) 2015 Artem Arslanov. All rights reserved.
 */
package ru.arslanov.core.advert
{
	import flash.events.IEventDispatcher;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public interface IPlatformAdapter extends IEventDispatcher
	{
		function get name():String;
		function get isSupported():Boolean;
		function get isShown():Boolean;
		function get isInterstitialReady():Boolean;
		function initialize():void;
		function destroy():void;
		function showInterstitial(location:String = ""):void;
	}
}
