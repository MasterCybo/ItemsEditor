/**
 * Copyright (c) 2015 Artem Arslanov. All rights reserved.
 */
package ru.arslanov.core.advert.adapters
{
	import flash.events.EventDispatcher;
	
	import ru.arslanov.core.advert.IPlatformAdapter;
	
	import so.cuo.platform.iad.IAd;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class AppleIAdAdapter extends EventDispatcher implements IPlatformAdapter
	{
		private var _platform:IAd;
		private var _inShown:Boolean;

		public function AppleIAdAdapter( ADMOB_IOS_UNIT_ID:String )
		{
		}

		public function initialize():void
		{
			_platform = IAd.getInstance();
		}

		public function destroy():void
		{
			_platform.dispose();
			_platform = null;
		}

		public function get platform():IAd { return _platform; }

		public function get isSupported():Boolean { return platform.supportDevice(); }

		public function get isShown():Boolean { return _inShown; }

		public function showInterstitial(location:String = ""):void
		{
			platform.showInterstitial();
		}
	}
}
