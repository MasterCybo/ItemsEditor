/**
 * Created by Artem on 09.09.2015.
 */
package ru.arslanov.core.advert.adapters
{
	import com.amazon.mas.cpt.ads.Ad;
	import com.amazon.mas.cpt.ads.AmazonMobileAds;
	import com.amazon.mas.cpt.ads.ApplicationKey;
	import com.amazon.mas.cpt.ads.ShouldEnable;

	import flash.events.EventDispatcher;

	import ru.arslanov.core.advert.IPlatformAdapter;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class AmazonAdsAdapter extends EventDispatcher implements IPlatformAdapter
	{
		public static const NAME:String = "AmazonAds";

		private var _appKey:String;
		private var _isShown:Boolean;

		public function AmazonAdsAdapter(appKey:String)
		{
			_appKey = appKey;
		}
		
		public function initialize():void
		{
			if (!isSupported) return;

			AmazonMobileAds.setApplicationKey(new ApplicationKey(_appKey));
			AmazonMobileAds.registerApplication();

			AmazonMobileAds.enableGeoLocation(new ShouldEnable(true));
			AmazonMobileAds.enableLogging(new ShouldEnable(true));
			AmazonMobileAds.enableTesting(new ShouldEnable(true));

			var response:Ad = AmazonMobileAds.createInterstitialAd();
		}
		
		public function destroy():void
		{
		}
		
		public function get isSupported():Boolean { return AmazonMobileAds.isSupported(); }
		
		public function get isShown():Boolean { return _isShown; }
		
		public function showInterstitial( location:String = "" ):void
		{
		}

		public function get name():String { return NAME; }
		
		public function get isInterstitialReady():Boolean
		{
			return false;
		}
	}
}
