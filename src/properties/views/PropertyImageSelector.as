package properties.views
{
	import base.views.AppPickerList;
	
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.data.VectorCollection;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.VerticalAlign;
	
	import properties.controllers.PropertyImageSelectorController;
	import properties.events.PropertyEditorEvent;
	
	import starling.events.Event;
	
	public class PropertyImageSelector extends LayoutGroup
	{
		private static var _dataProvider:VectorCollection = new VectorCollection();
		
		private var _name:String;
		private var _image:String;
		private var _imagePicker:AppPickerList;
		
		public function PropertyImageSelector(name:String, image:String = null)
		{
			_name = name;
			_image = image;
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			var thisLayout:HorizontalLayout = new HorizontalLayout();
			thisLayout.verticalAlign = VerticalAlign.MIDDLE;
			thisLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
			thisLayout.gap = 5;
			layout = thisLayout;
			
			var title:Label = new Label();
			title.layoutData = new HorizontalLayoutData(20);
			title.text = _name;
			addChild(title);
			
			_imagePicker = new AppPickerList();
//			_imagePicker.bubblingEvents = false;
			_imagePicker.dataProvider = _dataProvider;
			_imagePicker.layoutData = new HorizontalLayoutData(80);
			addChild(_imagePicker);
			
			addEventListener(Event.CHANGE, changedHandler);
			
			new PropertyImageSelectorController(this);
		}
		
		override public function dispose():void
		{
			removeEventListener(Event.CHANGE, changedHandler);
			super.dispose();
		}
		
		private function changedHandler(event:Event):void
		{
			event.stopImmediatePropagation();
			event.stopPropagation();
			
			if (event.type == Event.CHANGE) {
				if (_imagePicker.selectedItem && _imagePicker.selectedItem != _image) {
					var image:String = _imagePicker.selectedItem as String;
					dispatchEvent(new PropertyEditorEvent(PropertyEditorEvent.CHANGED_VALUE, _name, image));
				}
			}
		}
		
		public function set images(value:Vector.<String>):void
		{
			_dataProvider.vectorData = value;
			
			_imagePicker.selectedItem = _image;
		}
	}
}
