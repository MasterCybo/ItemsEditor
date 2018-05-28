/**
 * Copyright (c) 2015 Artem Arslanov. All rights reserved.
 */
package ru.arslanov.core.advert.adapters
{
	import com.applovin.sdk.air.ads.AppLovinAdType;
	import com.applovin.sdk.air.ads.AppLovinExtension;
	import com.applovin.sdk.air.events.AppLovinDisplayEvent;
	import com.applovin.sdk.air.events.AppLovinErrorCodes;
	import com.applovin.sdk.air.events.AppLovinEvent;
	import com.applovin.sdk.air.events.AppLovinLoadEvent;
	
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;

	import ru.arslanov.core.advert.AdAdapterEvent;

	import ru.arslanov.core.advert.IPlatformAdapter;
	import ru.arslanov.core.utils.Log;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class AppLovinAdapter extends EventDispatcher implements IPlatformAdapter
	{
		public static const NAME:String = "AppLovin";

		private var _sdkKey:String;
		private var _platform:AppLovinExtension;
		private var _isShown:Boolean;

		public function AppLovinAdapter(sdkKey:String)
		{
			_sdkKey = sdkKey;
		}

		public function get name():String { return NAME; }
		public function get platform():AppLovinExtension { return _platform; }

		public function initialize():void
		{
			if (Capabilities.manufacturer.toLowerCase().indexOf("win") != -1) return;

			_platform = AppLovinExtension.instance;
			if (!platform) return;
			platform.verboseLogging = true;
			platform.sdkKey = _sdkKey;
			platform.initializeSdk();
			platform.addEventListener(AppLovinEvent.LOAD, onLoaded);
			platform.addEventListener(AppLovinEvent.DISPLAY, onDisplay);
			

			log("Initialized!");
			log("sdkKey : " + platform.sdkKey);
		}

		public function destroy():void
		{
			platform.removeEventListener(AppLovinEvent.LOAD, onLoaded);
			platform.removeEventListener(AppLovinEvent.DISPLAY, onDisplay);
			_platform = null;
		}

		public function get isSupported():Boolean { return platform != null; }
		public function get isShown():Boolean { return _isShown; }
		
		public function get isInterstitialReady():Boolean
		{
			return platform.isPreloadedAdReady(AppLovinAdType.interstitial);
		}
		
		public function showInterstitial(location:String = ""):void
		{
			platform.loadAndShowAd(AppLovinAdType.interstitial);
		}

		private function onLoaded(event:AppLovinLoadEvent):void
		{
			var loadWasSuccessful:Boolean = event.success;
			var adType:AppLovinAdType = event.adType;

			log("onLoaded");
			log("loadWasSuccessful : " + loadWasSuccessful);
			log("adType : " + adType);

			if(loadWasSuccessful) {
				// Do something with this knowledge - either remember that an ad is ready, or show it.
			} else {
				var errorCode:Number = event.errorCode;
				if(errorCode == AppLovinErrorCodes.noFill) {
					// No ads are currently available for this device & location.
					errorHandler("No ads are currently available for this device & location");
				} else {
					// Other failure, most likely network (bad signal or airplane mode)
					errorHandler("Other failure, most likely network (bad signal or airplane mode)");
				}
			}
		}

		/**
		 * Универсальный обработчик ошибок
		 * @param message
		 */
		private function errorHandler( message:String ):void
		{
			log( message );
			_isShown = false;
			dispatchEvent(new AdAdapterEvent(AdAdapterEvent.ERROR_INTERSTITIAL));
		}

		private function onDisplay(event:AppLovinDisplayEvent):void
		{
			var description:String = event.description;
			var adType:AppLovinAdType = event.adType;

			log("onDisplay");
			log("description : " + description);
			log("adType : " + adType);

			if(description == AppLovinDisplayEvent.adDisplayed) {
				// An ad of this type is now on screen.
				// If this is an interstitial or rewarded video, you'll want to pause your game.
				_isShown = true;
				dispatchEvent(new AdAdapterEvent(AdAdapterEvent.DISPLAY_INTERSTITIAL));
			} else
			if(description == AppLovinDisplayEvent.adHidden) {
				// An ad of this type is no longer on screen.
				// Your game can now safely be resumed.
				_isShown = false;
				dispatchEvent(new AdAdapterEvent(AdAdapterEvent.CLOSED_INTERSTITIAL));
			} else
			if(description == AppLovinDisplayEvent.adClicked) {
				// The player clicked on this ad - your app is about to be minimized as we open the App Store / Google Play.
				_isShown = false;
				dispatchEvent(new AdAdapterEvent(AdAdapterEvent.CLICKED_INTERSTITIAL));
			} else
			if(description == AppLovinDisplayEvent.adVideoBegan) {
				// This was a video ad, and said video has started playing. Pause your background music, if any.
			}else
			if(description == AppLovinDisplayEvent.adVideoEnded) {
				// This was a video ad, and said video has ended. You may now safely resume any background music.
			}
		}

		public function log(txt:String):void {
			Log.traceText(name + " : " + txt);
		}
	}
}
