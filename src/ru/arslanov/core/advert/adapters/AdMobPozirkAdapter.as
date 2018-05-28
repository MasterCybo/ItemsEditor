/**
 * Copyright (c) 2015 Artem Arslanov. All rights reserved.
 */
package ru.arslanov.core.advert.adapters
{
	import com.pozirk.ads.admob.AdEvent;
	import com.pozirk.ads.admob.AdMob;
	
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	
	import ru.arslanov.core.advert.AdAdapterEvent;
	
	import ru.arslanov.core.advert.IPlatformAdapter;
	import ru.arslanov.core.utils.Log;
	
	/**
	 * https://github.com/pozirk/ANEAdMob
	 * @author Artem Arslanov
	 */
	public class AdMobPozirkAdapter extends EventDispatcher implements IPlatformAdapter
	{
		public static const NAME:String = "AdMob Pozirk";

		private var _interstitialId:String;
		private var _platform:AdMob;
		private var _isShown:Boolean;

		public function AdMobPozirkAdapter(interstitialId:String)
		{
			_interstitialId = interstitialId;
		}

		public function initialize():void
		{
			_platform = new AdMob();
			platform.addEventListener(AdEvent.INIT_OK, onPlatformHandler);
			platform.addEventListener(AdEvent.INIT_FAIL, onPlatformHandler);
			platform.addEventListener(AdEvent.INTERSTITIAL_SHOW_OK, onPlatformHandler);
			platform.addEventListener(AdEvent.INTERSTITIAL_SHOW_FAIL, onPlatformHandler);
			platform.addEventListener(AdEvent.INTERSTITIAL_CACHE_OK, onPlatformHandler);
			platform.addEventListener(AdEvent.INTERSTITIAL_CACHE_FAIL, onPlatformHandler);
			platform.addEventListener(AdEvent.INTERSTITIAL_LEFT_APP, onPlatformHandler);
			platform.addEventListener(AdEvent.INTERSTITIAL_OPENED, onPlatformHandler);
			platform.addEventListener(AdEvent.INTERSTITIAL_CLOSED, onPlatformHandler);
			platform.init();
		}

		public function get name():String { return NAME; }
		public function get platform():AdMob { return _platform; }
		public function get isSupported():Boolean { return !Capabilities.isDebugger; }
		public function get isShown():Boolean { return _isShown; }

		public function destroy():void
		{
			platform.removeEventListener(AdEvent.INIT_OK, onPlatformHandler);
			platform.removeEventListener(AdEvent.INIT_FAIL, onPlatformHandler);
			platform.removeEventListener(AdEvent.INTERSTITIAL_SHOW_OK, onPlatformHandler);
			platform.removeEventListener(AdEvent.INTERSTITIAL_SHOW_FAIL, onPlatformHandler);
			platform.removeEventListener(AdEvent.INTERSTITIAL_CACHE_OK, onPlatformHandler);
			platform.removeEventListener(AdEvent.INTERSTITIAL_CACHE_FAIL, onPlatformHandler);
			platform.removeEventListener(AdEvent.INTERSTITIAL_LEFT_APP, onPlatformHandler);
			platform.removeEventListener(AdEvent.INTERSTITIAL_OPENED, onPlatformHandler);
			platform.removeEventListener(AdEvent.INTERSTITIAL_CLOSED, onPlatformHandler);
			_platform.dispose();
			_platform = null;
		}
		
		public function showInterstitial(location:String = ""):void
		{
			log("showInterstitial : " + _interstitialId);
			platform.cacheInterstitial(_interstitialId);
		}

		private function onPlatformHandler(event:AdEvent):void
		{
			switch (event.type) {
				case AdEvent.INIT_OK:
					log("Inited!");
					break;
				case AdEvent.INIT_FAIL:
					log("Init ERROR! " + event._data);
					dispatchEvent(new AdAdapterEvent(AdAdapterEvent.ERROR_INTERSTITIAL));
					break;
				case AdEvent.INTERSTITIAL_CACHE_OK:
					log("Interstitial cache ok : " + event._data);
					platform.showInterstitial();
					break;
				case AdEvent.INTERSTITIAL_CACHE_FAIL:
					log("Interstitial cache ERROR! : " + event._data);
					dispatchEvent(new AdAdapterEvent(AdAdapterEvent.ERROR_INTERSTITIAL));
					break;
				case AdEvent.INTERSTITIAL_SHOW_OK:
					log("Interstitial show OK : " + event._data);
					_isShown = true;
					break;
				case AdEvent.INTERSTITIAL_SHOW_FAIL:
					log("Interstitial show ERROR : " + event._data);
					_isShown = false;
					dispatchEvent(new AdAdapterEvent(AdAdapterEvent.ERROR_INTERSTITIAL));
					break;
				case AdEvent.INTERSTITIAL_OPENED:
					log("Interstitial show OPENED : " + event._data);
					break;
				case AdEvent.INTERSTITIAL_CLOSED:
					log("Interstitial show CLOSED : " + event._data);
					_isShown = false;
					dispatchEvent(new AdAdapterEvent(AdAdapterEvent.CLOSED_INTERSTITIAL));
					break;
				case AdEvent.INTERSTITIAL_LEFT_APP:
					log("Interstitial show LEFT_APP : " + event._data);
					break;
			}
		}

		public function log(txt:String):void
		{
			Log.traceText(name + " : " + txt);
		}
		
		public function get isInterstitialReady():Boolean
		{
			return false;
		}
	}
}
