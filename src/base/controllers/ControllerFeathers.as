package base.controllers
{
	import feathers.core.FeathersControl;
	import feathers.events.FeathersEventType;
	
	import flash.events.EventDispatcher;
	
	import starling.events.Event;
	
	public class ControllerFeathers
	{
		public static var _eventDispatcher:EventDispatcher;
		
		public static function config(eventDispatcher:EventDispatcher):void
		{
			_eventDispatcher = eventDispatcher;
		}
		
		
		private var _view:FeathersControl;
		
		public function ControllerFeathers(view:FeathersControl)
		{
			_view = view;
			_view.isCreated ? initialize() : _view.addEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		private function creationCompleteHandler(event:Event):void
		{
			_view.removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
			initialize();
			_view.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		private function removedFromStageHandler(event:Event):void
		{
			destroy();
		}
		
		protected function getView():FeathersControl {return _view;}
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
			
			_view.removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			_view = null;
		}
	}
}
