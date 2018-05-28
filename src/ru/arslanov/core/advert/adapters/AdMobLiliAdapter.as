/**
 * Copyright (c) 2015 Artem Arslanov. All rights reserved.
 */
package ru.arslanov.core.advert.adapters
{
	import flash.events.EventDispatcher;

	import ru.arslanov.core.advert.AdAdapterEvent;
	import ru.arslanov.core.advert.IPlatformAdapter;
	import ru.arslanov.core.utils.Log;

	import so.cuo.platform.admob.Admob;
	import so.cuo.platform.admob.AdmobEvent;


	/**
	 * https://github.com/lilili87222/admob-for-flash
	 * @author Artem Arslanov
	 */
	public class AdMobLiliAdapter extends EventDispatcher implements IPlatformAdapter
	{
		public static const NAME:String = "AdMob Lilili";

		private var _interstitialId:String;
		private var _platform:Admob;
		private var _isShown:Boolean;

		public function AdMobLiliAdapter(interstitialId:String)
		{
			_interstitialId = interstitialId;
		}

		public function initialize():void
		{
			_platform = Admob.getInstance();
			if(!isSupported) return;

			platform.setKeys(null, _interstitialId);

			platform.enableTrace = true;

			platform.addEventListener(AdmobEvent.onInterstitialPresent, onInterstitialHandler);
			platform.addEventListener(AdmobEvent.onInterstitialReceive, onInterstitialHandler);
			platform.addEventListener(AdmobEvent.onInterstitialLeaveApplication, onInterstitialHandler);
			platform.addEventListener(AdmobEvent.onInterstitialFailedReceive, onInterstitialHandler);
			platform.addEventListener(AdmobEvent.onInterstitialDismiss, onInterstitialHandler);

			log("Inited!");
			log("Version : " + Admob.version);
		}

		public function get name():String { return NAME; }
		public function get platform():Admob { return _platform; }
		public function get isSupported():Boolean { return platform.supportDevice; }
		public function get isShown():Boolean { return _isShown; }

		public function destroy():void
		{
			platform.removeEventListener(AdmobEvent.onInterstitialPresent, onInterstitialHandler);
			platform.removeEventListener(AdmobEvent.onInterstitialReceive, onInterstitialHandler);
			platform.removeEventListener(AdmobEvent.onInterstitialLeaveApplication, onInterstitialHandler);
			platform.removeEventListener(AdmobEvent.onInterstitialFailedReceive, onInterstitialHandler);
			platform.removeEventListener(AdmobEvent.onInterstitialDismiss, onInterstitialHandler);
			_platform.dispose();
			_platform = null;
		}

		public function showInterstitial(location:String = ""):void
		{
			if (platform.isInterstitialReady()) {
				platform.showInterstitial();
			} else {
				platform.cacheInterstitial();
			}
		}

		private function onInterstitialHandler(event:AdmobEvent):void
		{
			switch (event.type) {
				case AdmobEvent.onInterstitialReceive:
					log("Interstitial receive : " + event.data);
					platform.showInterstitial();
					break;
				case AdmobEvent.onInterstitialPresent:
					log("Interstitial present : " + event.data);
					_isShown = true;
					dispatchEvent(new AdAdapterEvent(AdAdapterEvent.DISPLAY_INTERSTITIAL, "Interstitial display"));
					break;
				case AdmobEvent.onInterstitialLeaveApplication:
					log("Interstitial leave application : " + event.data);
					_isShown = false;
					dispatchEvent(new AdAdapterEvent(AdAdapterEvent.CLOSED_INTERSTITIAL));
					break;
				case AdmobEvent.onInterstitialDismiss:
					log("Interstitial dismiss (click close) : " + event.data);
					_isShown = false;
					dispatchEvent(new AdAdapterEvent(AdAdapterEvent.CLOSED_INTERSTITIAL));
					break;
				case AdmobEvent.onInterstitialFailedReceive:
					log("Interstitial failed receive : " + event.data);
					_isShown = false;
					dispatchEvent(new AdAdapterEvent(AdAdapterEvent.ERROR_INTERSTITIAL, "" + event.data));
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
