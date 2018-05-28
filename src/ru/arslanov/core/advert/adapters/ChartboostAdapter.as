/**
 * Copyright (c) 2015 Artem Arslanov. All rights reserved.
 */
package ru.arslanov.core.advert.adapters
{
	import com.chartboost.plugin.air.CBLoadError;
	import com.chartboost.plugin.air.Chartboost;
	import com.chartboost.plugin.air.ChartboostEvent;

	import flash.events.EventDispatcher;

	import ru.arslanov.core.advert.AdAdapterEvent;
	import ru.arslanov.core.advert.IPlatformAdapter;
	import ru.arslanov.core.utils.Log;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class ChartboostAdapter extends EventDispatcher implements IPlatformAdapter
	{
		public static const NAME:String = "Chartboost";

		private var _appId:String;
		private var _appSignature:String;
		private var _platform:Chartboost;
		private var _isShown:Boolean;

		public function ChartboostAdapter(appId:String, appSignature:String)
		{
			_appId = appId;
			_appSignature = appSignature;
		}

		public function initialize():void
		{
			_platform = Chartboost.getInstance();
			if (!isSupported) return;

			platform.startWith(_appId, _appSignature);
			addDelegateMethods();

			log("Inited!");
			log("appID = " + _appId);
			log("appSignature = " + _appSignature);
		}

		public function destroy():void
		{
			_platform.dispose();
			_platform = null;
		}

		public function get name():String { return NAME; }

		public function get platform():Chartboost { return _platform; }

		public function get isShown():Boolean { return _isShown; }

		public function get isSupported():Boolean { return Chartboost.isPluginSupported(); }

		/**
		 * Показать рекламную вставку
		 * @param location
		 */
		public function showInterstitial(location:String = "Default"):void
		{
			log("showInterstitial : " + location);
			location = location && (location != "") ? location : "Default";
			platform.showInterstitial(location);
		}

		/**
		 * Подписка на события
		 * @param eventName
		 * @param listener
		 */
		public function addDelegateEvent(eventName:String, listener:Function):void
		{
			platform.addDelegateEvent(eventName, listener);
		}

		private function onDisplayHandler(location:String):void
		{
			log("onDisplayHandler");
			_isShown = true;
			dispatchEvent(new AdAdapterEvent(AdAdapterEvent.DISPLAY_INTERSTITIAL));
		}

		/**
		 * Обработчик закрытия рекламной вставки
		 * @param location
		 */
		private function onCloseHandler(location:String):void
		{
			log("on Interstitial closed: " + location);
			_isShown = false;
			dispatchEvent(new AdAdapterEvent(AdAdapterEvent.CLOSED_INTERSTITIAL));
		}

		/**
		 * Обработчик ошибки загрузки рекламной вставки
		 * @param location
		 * @param error
		 */
		private function onFailLoadHandler(location:String, error:CBLoadError):void
		{
			errorHandler("on Interstitial failed to load " + location + " for reason " + error.Text);
		}

		/**
		 * Обработчик клика по рекламной вставке
		 * @param location
		 */
		private function onClickHandler(location:String):void
		{
			errorHandler("on Interstitial dismissed: " + location);
			dispatchEvent(new AdAdapterEvent(AdAdapterEvent.CLICKED_INTERSTITIAL));
		}

		/**
		 * Универсальный обработчик ошибок
		 * @param message
		 */
		private function errorHandler(message:String):void
		{
//			log(message);
			_isShown = false;
			dispatchEvent(new AdAdapterEvent(AdAdapterEvent.ERROR_INTERSTITIAL, message));
		}

		/**
		 * Подписка на события платформы
		 */
		private function addDelegateMethods():void
		{
			// Запускается, когда не удается загрузить рекламную вставку
			addDelegateEvent(ChartboostEvent.DID_FAIL_TO_LOAD_INTERSTITIAL, onFailLoadHandler);

			// Запускается при закрывании рекламной вставки (то есть, если пользователь нажимает «X» или кнопку «Назад» в Android).
			addDelegateEvent(ChartboostEvent.DID_CLOSE_INTERSTITIAL, onCloseHandler);

			// Запускается при клике на рекламной вставке.
			addDelegateEvent(ChartboostEvent.DID_DISMISS_INTERSTITIAL, onClickHandler);

			// Запускается при отображении рекламной вставки.
			addDelegateEvent(ChartboostEvent.DID_DISPLAY_INTERSTITIAL, onDisplayHandler);

			// Запускается, когда рекламная вставка прекращается любым способом. Всегда сопровождается событием закрывания или клика.
			addDelegateEvent(
					ChartboostEvent.DID_CLICK_INTERSTITIAL, function (location:String):void
					{
						log("on Interstitial clicked: " + location);
					}
			);

			// Запускается при кэшировании рекламной вставки.
			addDelegateEvent(
					ChartboostEvent.DID_CACHE_INTERSTITIAL, function (location:String):void
					{
						log("on Interstitial cached: " + location);
					}
			);

			/*
			 addDelegateEvent(ChartboostEvent.DID_FAIL_TO_LOAD_MOREAPPS, function (location:String, error:CBLoadError):void {
			 log( "Chartboost: on More Apps failed to load " + location + " for reason " + error.Text );
			 });

			 addDelegateEvent(ChartboostEvent.DID_CLICK_MORE_APPS, function (location:String):void {
			 log( "Chartboost: on More Apps clicked: " + location );
			 });

			 addDelegateEvent(ChartboostEvent.DID_CLOSE_MORE_APPS, function (location:String):void {
			 log( "Chartboost: on More Apps closed: " + location );
			 });

			 addDelegateEvent(ChartboostEvent.DID_DISMISS_MORE_APPS, function (location:String):void {
			 log( "Chartboost: on More Apps dismissed: " + location );
			 });

			 addDelegateEvent(ChartboostEvent.DID_CACHE_MORE_APPS, function (location:String):void {
			 log( "Chartboost: on More Apps cached: " + location );
			 });

			 addDelegateEvent(ChartboostEvent.DID_DISPLAY_MORE_APPS, function (location:String):void {
			 log( "Chartboost: on More Apps showed: " + location );
			 });
			 */
			/*
			 addDelegateEvent(ChartboostEvent.DID_FAIL_TO_RECORD_CLICK, function (location:String, error:CBClickError):void {
			 log( "Chartboost: on click failed to record " + location + " for reason " + error.Text );
			 });

			 addDelegateEvent(ChartboostEvent.DID_FAIL_TO_LOAD_REWARDED_VIDEO, function (location:String, error:CBLoadError):void {
			 log( "Chartboost: on Rewarded Video failed to load " + location + " for reason " + error.Text );
			 });

			 addDelegateEvent(ChartboostEvent.DID_CLICK_REWARDED_VIDEO, function (location:String):void {
			 log( "Chartboost: on Rewarded Video clicked: " + location );
			 });

			 addDelegateEvent(ChartboostEvent.DID_CLOSE_REWARDED_VIDEO, function (location:String):void {
			 log( "Chartboost: on Rewarded Video closed: " + location );
			 });

			 addDelegateEvent(ChartboostEvent.DID_COMPLETE_REWARDED_VIDEO, function (location:String, reward:int):void {
			 log( "Chartboost: on Rewarded Video completed " + location + " for reward " + reward );
			 });

			 addDelegateEvent(ChartboostEvent.DID_CACHE_REWARDED_VIDEO, function (location:String):void {
			 log( "Chartboost: on Rewarded Video cached: " + location );
			 });

			 addDelegateEvent(ChartboostEvent.DID_DISMISS_REWARDED_VIDEO, function (location:String):void {
			 log( "Chartboost: on Rewarded Video dismissed: " + location );
			 });

			 addDelegateEvent(ChartboostEvent.DID_DISPLAY_REWARDED_VIDEO, function (location:String):void {
			 log( "Chartboost: on Rewarded Video showed: " + location );
			 });

			 addDelegateEvent(ChartboostEvent.DID_COMPLETE_APP_STORE_SHEET_FLOW, function ():void {
			 log( "Chartboost: did complete iOS app store sheet flow" );
			 });

			 addDelegateEvent(ChartboostEvent.WILL_DISPLAY_VIDEO, function ():void {
			 log( "Chartboost: will display video" );
			 });

			 addDelegateEvent(ChartboostEvent.DID_CACHE_INPLAY, function (location:String):void {
			 log( "Chartboost: on InPlay cached: " + location );
			 });

			 addDelegateEvent(ChartboostEvent.DID_FAIL_TO_LOAD_INPLAY, function (location:String, error:CBLoadError):void {
			 log( "Chartboost: on InPlay failed to load " + location + " for reason " + error.Text );
			 });
			 */
		}

		public function log(txt:String):void
		{
			Chartboost.nativeLog(txt);
			Log.traceText("Chartboost : " + txt);
		}
		
		public function get isInterstitialReady():Boolean
		{
			return false;
		}
	}
}
