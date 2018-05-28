package contents.views
{
	import base.views.AppButton;
	
	import contents.models.IContentItem;
	
	import feathers.controls.Header;
	import feathers.controls.Panel;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	import contents.controllers.ContentsEditorPanelController;
	import contents.models.EffectContent;
	
	public class ContentsEditorPanel extends Panel
	{
		public static const ADD_BUTTON:String = "addButton";
		
		private static var _thisLayout:VerticalLayout;
		private static var _thisLayoutData:VerticalLayoutData = new VerticalLayoutData(100, 100);
		
		private var _contentsList:ContentsList;
		
		public function ContentsEditorPanel()
		{
			super();
			addEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		private static function thisLayout():VerticalLayout
		{
			if (!_thisLayout) {
				_thisLayout = new VerticalLayout();
				_thisLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
				_thisLayout.verticalAlign = VerticalAlign.JUSTIFY;
			}
			return _thisLayout;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			layout = thisLayout();
			layoutData = _thisLayoutData;
		}
		
		override public function dispose():void
		{
			_contentsList.dataProvider.removeEventListener(Event.CHANGE, changeListHandler);
			removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
			super.dispose();
		}
		
		private function creationCompleteHandler(event:Event):void
		{
			removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
			
			var addButton:AppButton = new AppButton("Add", ADD_BUTTON);
			
			var head:Header = Header(header);
			head.paddingBottom = 10;
			head.paddingTop = 10;
			head.leftItems = Vector.<DisplayObject>([addButton]);
			
			_contentsList = new ContentsList();
			addChild(_contentsList);
			
			_contentsList.dataProvider.addEventListener(Event.CHANGE, changeListHandler);
			
			new ContentsEditorPanelController(this);
		}
		
		private function changeListHandler(event:Event):void
		{
			validateHeader(_contentsList.numItems);
		}
		
		public function setData(content:Vector.<IContentItem> = null):void
		{
			if (content) validateHeader(content.length);
		}
		
		private function validateHeader(count:int):void
		{
			title = "Contents: " + count;
		}
	}
}
