/**
 * Created by Artem on 24.04.2016.
 */
package ru.arslanov.core.utils
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Delay
	{
		private static var _onComplete:Function;

		public static function run(seconds:Number, onComplete:Function):void
		{
			_onComplete = onComplete;
			
			var timer:Timer = new Timer(seconds * 1000);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}

		private static function onTimer(event:TimerEvent):void
		{
			var timer:Timer = event.target as Timer;
			timer.removeEventListener(TimerEvent.TIMER, onTimer);

			if (_onComplete != null) {
				var fn:Function = _onComplete;
				_onComplete = null;
				fn();
			}
		}
	}
}
