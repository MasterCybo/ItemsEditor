package base.controllers
{
	import flash.events.EventDispatcher;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class ControllerStarling
	{
		private static var _eventDispatcher:EventDispatcher;
		
		public static function config(eventDispatcher:EventDispatcher):void
		{
			_eventDispatcher = eventDispatcher;
		}
		
		private var _view:DisplayObject;
		
		public function ControllerStarling(view:DisplayObject)
		{
			_view = view;
			_view.stage ? initialize() : _view.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			_view.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			initialize();
			_view.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		private function removedFromStageHandler(event:Event):void
		{
			destroy();
		}
		
		protected function get view():DisplayObject {return _view;}
		protected function get eventDispatcher():EventDispatcher {
			if (!_eventDispatcher) _eventDispatcher = new EventDispatcher();
			return _eventDispatcher;
		}
		
		protected function initialize():void
		{
			// Override me
		}
		
		public function destroy():void
		{
			if (!_view) return;
			
			_view.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			_view = null;
		}
	}
}
