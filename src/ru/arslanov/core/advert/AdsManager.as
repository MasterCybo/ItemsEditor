/**
 * Copyright (c) 2015 Artem Arslanov. All rights reserved.
 */
package ru.arslanov.core.advert
{
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;

	import ru.arslanov.core.utils.Log;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class AdsManager extends EventDispatcher
	{
		// Singleton
		static private var _instance:AdsManager;

		static public function get me():AdsManager
		{
			if (!_instance) _instance = new AdsManager(new PrivateKey());
			return _instance;
		}




		private var _platforms:Vector.<IPlatformAdapter> = new Vector.<IPlatformAdapter>();
		private var _adapter:IPlatformAdapter;
		private var _indexPlatform:uint;

		private var _isAndroind:Boolean;
		private var _isIOS:Boolean;

		private var _onCloseCallback:Function;

		private var _location:String = "";

		public function AdsManager(key:PrivateKey)
		{
			if (!key) throw new Error("Error: Instantiation failed: Use AdsService.me instead of new.");

//			var manufacturer:String = Capabilities.manufacturer;
//			var version:String = Capabilities.version;
//			var os:String = Capabilities.os;

//			trace( "manufacturer : " + manufacturer );
//			trace( "version : " + version );
//			trace( "os : " + os );

			var idxAnd:int = Capabilities.manufacturer.toLowerCase().indexOf("and");
			var idxIOS:int = Capabilities.manufacturer.toLowerCase().indexOf("ios"); // TODO проверить

			_isAndroind = (idxAnd != -1) && (idxIOS == -1);
			_isIOS = (idxAnd == -1) && (idxIOS != -1);
		}

		public function destroy():void
		{
			_onCloseCallback = null;

			var adapter:IPlatformAdapter;
			for each ( adapter in _platforms ) {
				adapter.removeEventListener(AdAdapterEvent.ERROR_INTERSTITIAL, onErrorInterstitial);
				adapter.removeEventListener(AdAdapterEvent.CLOSED_INTERSTITIAL, onClosedInterstitial);
				adapter.destroy();
			}
		}

		public function get isAndroid():Boolean { return _isAndroind; }
		public function get isIOS():Boolean { return _isIOS; }

		public function addPlatform(adapter:IPlatformAdapter):void
		{
			_platforms.push(adapter);

			adapter.addEventListener(AdAdapterEvent.ERROR_INTERSTITIAL, onErrorInterstitial);
			adapter.addEventListener(AdAdapterEvent.CLOSED_INTERSTITIAL, onClosedInterstitial);
			adapter.initialize();
		}

		public function showInterstitial(closeCallback:Function, location:String = ""):void
		{
			_onCloseCallback = closeCallback;
			_location = location;
			_indexPlatform = 0;
			showNextInterstitial();
		}

		private function showNextInterstitial():void
		{
			if (_indexPlatform < _platforms.length) {
				log("Show platform " + (_indexPlatform + 1) + " of " + _platforms.length);
				_adapter = _platforms[_indexPlatform];
				log("Platform adapter : " + _adapter.name);
				if (_adapter.isSupported) {
					if (!_adapter.isShown) {
						log("show Interstitial " + _location);
						_adapter.showInterstitial(_location);
					} else {
						log("interstitial already shown!");
						callClose();
					}
				} else {
					log("adapter " + _adapter.name + " is not supported!");
					_indexPlatform++;
					showNextInterstitial();
				}
			} else {
				callClose();
			}
		}

		private function onClosedInterstitial(event:AdAdapterEvent):void
		{
			callClose();
		}

		private function onErrorInterstitial(event:AdAdapterEvent):void
		{
			log("Error : " + (event.target as IPlatformAdapter).name + ", message : " + event.message);
			showNextInterstitial();
		}

		private function callClose():void
		{
			log(_adapter.name + " close Interstitial");
			if (_onCloseCallback != null) {
				_onCloseCallback();
			}
		}

		public function log(txt:String):void {
			Log.traceText("AdsManager : " + txt);
		}
	}
}

internal class PrivateKey
{
}
