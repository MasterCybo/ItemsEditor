package properties.views
{
	import base.views.ITextEditor;
	
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.VerticalAlign;
	
	import properties.events.PropertyEditorEvent;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.text.TextFormat;
	
	public class PropertyEditorAbstract extends LayoutGroup
	{
		private static var _titleLayoutData:HorizontalLayoutData = new HorizontalLayoutData();
		
		private var _name:String;
		private var _value:*;
		
		private var _input:ITextEditor;
		
		protected var titleWidthPercent:Number = 20;
		protected var textInputWidthPercent:Number = 80;
		
		public function PropertyEditorAbstract(name:String, value:* = null)
		{
			super();
			_name = name;
			_value = value;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			var thisLayout:HorizontalLayout = new HorizontalLayout();
			thisLayout.verticalAlign = VerticalAlign.MIDDLE;
			thisLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
			thisLayout.gap = 5;
			layout = thisLayout;
			
			_titleLayoutData.percentWidth = titleWidthPercent;
			
			var title:Label = titleFactory();
			title.layoutData = _titleLayoutData;
			title.text = _name;
			addChild(title);
			
			var textFormat:TextFormat = title.fontStyles;
			textFormat.horizontalAlign = HorizontalAlign.RIGHT;
//			title.fontStyles = textFormat;
			
			_input = textInputFactory();
			_input.text = _value;
			_input.layoutData = new HorizontalLayoutData(textInputWidthPercent);
			_input.addEventListener(Event.CHANGE, changeHandler);
			addChild(_input as DisplayObject);
		}
		
		override public function dispose():void
		{
			_input.removeEventListener(Event.CHANGE, changeHandler);
			super.dispose();
		}
		
		private function changeHandler(event:Event):void
		{
			switch (event.type) {
				case Event.CHANGE:
					dispatchEvent(new PropertyEditorEvent(PropertyEditorEvent.CHANGED_VALUE, _name, _input.text));
					break;
			}
		}
		
		protected function titleFactory():Label
		{
			return null;
		}
		
		protected function textInputFactory():ITextEditor
		{
			return null;
		}
	}
}
