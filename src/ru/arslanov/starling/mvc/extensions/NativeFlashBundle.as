package ru.arslanov.starling.mvc.extensions
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import ru.arslanov.starling.mvc.context.IContext;
	import ru.arslanov.starling.mvc.events.ContextEvent;
	
	public class NativeFlashBundle extends Extension
	{
		private var _contextView:DisplayObject;
		
		public function NativeFlashBundle(context:IContext)
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
				throw new Error("Context view is not flash.display.DisplayObject!");
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
		
		private function onAdded(event:Event):void
		{
			mediateView(event.target as DisplayObject);
		}
		
		private function onRemoved(event:Event):void
		{
			unmediateView(event.target as DisplayObject);
		}
		
		private function mediateView(view:DisplayObject):void
		{
			context.mediatorMap.mediate(view);
			
			mediateChildren(view as DisplayObjectContainer);
			
//			var container:DisplayObjectContainer = view as DisplayObjectContainer;
//			if (container) {
//				var child:DisplayObject;
//				for (var i:int = 0; i < container.numChildren; i++) {
//					child = container.getChildAt(i);
//					mediateView(child);
//				}
//			}
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
			context.mediatorMap.unmediate(view);
			
			unmediateChildren(view as DisplayObjectContainer);
			
//			var container:DisplayObjectContainer = view as DisplayObjectContainer;
//			if (container) {
//				var child:DisplayObject;
//				for (var i:int = 0; i < container.numChildren; i++) {
//					child = container.getChildAt(i);
//					unmediateView(child);
//				}
//			}
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
