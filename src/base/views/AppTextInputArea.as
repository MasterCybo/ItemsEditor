package base.views
{
	import feathers.controls.ScrollInteractionMode;
	import feathers.controls.ScrollPolicy;
	import feathers.controls.TextArea;
	import feathers.events.FeathersEventType;
	
	import starling.events.Event;
	
	public class AppTextInputArea extends TextArea implements ITextEditor
	{
		public function AppTextInputArea(text:* = "")
		{
			super();
			
			isEditable = true;
			
			textEditorProperties.wordWrap = true;
			textEditorProperties.multiline = true;
			textEditorProperties.paddingTop = textEditorProperties.paddingBottom = 5;
			
			scrollBarDisplayMode = ScrollInteractionMode.TOUCH_AND_SCROLL_BARS;
			verticalScrollPolicy = ScrollPolicy.ON;
			
			this.text = text;
			
			addEventListener(Event.CHANGE, eventHandler);
			addEventListener(FeathersEventType.ENTER, eventHandler);
			addEventListener(FeathersEventType.FOCUS_IN, eventHandler);
			addEventListener(FeathersEventType.FOCUS_OUT, eventHandler);
			addEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		private function creationCompleteHandler(event:Event):void
		{
			removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
			
			textEditorProperties.paddingRight = verticalScrollBar.width - 5;
		}
		
		override public function dispose():void
		{
			removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
			removeEventListener(Event.CHANGE, eventHandler);
			removeEventListener(FeathersEventType.ENTER, eventHandler);
			removeEventListener(FeathersEventType.FOCUS_IN, eventHandler);
			removeEventListener(FeathersEventType.FOCUS_OUT, eventHandler);
			super.dispose();
		}
		
		private function eventHandler(event:Event):void
		{
			event.stopImmediatePropagation();
			event.stopPropagation();
			
			removeEventListener(event.type, eventHandler);
			
			dispatchEventWith(event.type, true);
			
			addEventListener(event.type, eventHandler);
		}
	}
}
