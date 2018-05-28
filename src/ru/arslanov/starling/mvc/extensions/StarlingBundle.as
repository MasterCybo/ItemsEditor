package ru.arslanov.starling.mvc.extensions
{
	import ru.arslanov.starling.mvc.context.IContext;
	import ru.arslanov.starling.mvc.events.ContextEvent;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	public class StarlingBundle extends Extension
	{
		private var _contextView:DisplayObject;
		
		public function StarlingBundle(context:IContext)
		{
			super(context);
		}
		
		override public function initialize():void
		{
			context.addEventListener(ContextEvent.CONTEXT_VIEW_ADDED, viewAddedHandler);
		}
		
		private function viewAddedHandler(event:ContextEvent):void
		{
			context.removeEventListener(ContextEvent.CONTEXT_VIEW_ADDED, viewAddedHandler);
			
			_contextView = context.contextView as DisplayObject;
			
			if (!_contextView) {
				throw new Error("Context view is not starling.display.DisplayObject!");
			}
			
			if (_contextView.stage) {
				addedToStageHandler();
			} else {
				_contextView.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			}
		}
		
		private function addedToStageHandler(event:Event = null):void
		{
			_contextView.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			_contextView.stage.addEventListener(Event.ADDED, onAdded);
			_contextView.stage.addEventListener(Event.REMOVED, onRemoved);
			mediateView(_contextView);
		}
		
		protected function onAdded(event:Event):void
		{
			mediateView(event.target as DisplayObject);
		}
		
		protected function onRemoved(event:Event):void
		{
			unmediateView(event.target as DisplayObject);
		}
		
		private function mediateView(view:DisplayObject):void
		{
			if (!context.mediatorMap.isMediated(view)) context.mediatorMap.mediate(view);
			mediateChildren(view as DisplayObjectContainer);
		}
		
		private function mediateChildren(container:DisplayObjectContainer):void
		{
			if (!container) return;
			
			var child:DisplayObject;
			for (var i:int = 0; i < container.numChildren; i++) {
				child = container.getChildAt(i);
				mediateView(child);
			}
		}
		
		private function unmediateView(view:DisplayObject):void
		{
			if (context.mediatorMap.isMediated(view)) context.mediatorMap.unmediate(view);
			unmediateChildren(view as DisplayObjectContainer);
		}
		
		private function unmediateChildren(container:DisplayObjectContainer):void
		{
			if (!container) return;
			
			var child:DisplayObject;
			for (var i:int = 0; i < container.numChildren; i++) {
				child = container.getChildAt(i);
				unmediateView(child);
			}
		}
	}
}
