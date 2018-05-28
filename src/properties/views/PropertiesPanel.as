package properties.views
{
	import feathers.controls.Header;
	import feathers.controls.Panel;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;
	
	import items.models.MoItem;
	
	import properties.controllers.PropertiesPanelController;
	
	import starling.events.Event;
	
	import contents.views.ContentsEditorPanel;
	
	public class PropertiesPanel extends Panel
	{
		private static var _thisLayout:VerticalLayout;
		
		private var _propsList:PropertiesList;
		private var _stuffingEditor:ContentsEditorPanel;
		
		public function PropertiesPanel()
		{
			super();
			addEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		override public function dispose():void
		{
			removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
			super.dispose();
		}
		
		private static function thisLayout():VerticalLayout
		{
			if (!_thisLayout) {
				_thisLayout = new VerticalLayout();
				_thisLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
				_thisLayout.verticalAlign = VerticalAlign.JUSTIFY;
				_thisLayout.gap = 10;
			}
			return _thisLayout;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			layout = thisLayout();
			
			_propsList = new PropertiesList();
			addChild(_propsList);
			
			_stuffingEditor = new ContentsEditorPanel();
			_stuffingEditor.visible = false;
			addChild(_stuffingEditor);
		}
		
		private function creationCompleteHandler(event:Event):void
		{
			removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
			
			var head:Header = Header(header);
			head.paddingBottom = 15;
			head.paddingTop = 15;
			
			new PropertiesPanelController(this);
		}
		
		public function setData(item:MoItem = null):void
		{
			_propsList.setData(item);
			_stuffingEditor.visible = item != null;
			
			if (item) {
				title = "ID: " + item.id;
			} else {
				title = "No selected item";
			}
		}
	}
}
