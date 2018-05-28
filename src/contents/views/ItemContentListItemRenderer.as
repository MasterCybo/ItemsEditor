package contents.views
{
	import base.views.AppButton;
	import base.views.AppPickerList;
	import base.views.AppTextInput;
	
	import contents.controllers.ItemContentListItemController;
	import contents.events.ContentListItemEvent;
	import contents.events.ItemContentEvent;
	import contents.models.ItemContent;
	
	import core.models.DataStore;
	
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.IToggle;
	import feathers.data.VectorCollection;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.VerticalAlign;
	
	import flash.events.EventDispatcher;
	
	import items.models.MoItem;
	
	import starling.events.Event;
	
	public class ItemContentListItemRenderer extends LayoutGroup implements IListItemRenderer, IToggle
	{
		private static var _itemsPickerList:VectorCollection;
		
		public static function get itemsCollection():VectorCollection
		{
			if (!_itemsPickerList) _itemsPickerList = new VectorCollection();
			return _itemsPickerList;
		}
		
		
		private static const _pickerLayoutData:HorizontalLayoutData = new HorizontalLayoutData(60);
		private static const _inputLayoutData:HorizontalLayoutData = new HorizontalLayoutData(25);
		private static const _removeLayoutData:HorizontalLayoutData = new HorizontalLayoutData(15);
		
		private static var _thisLayout:HorizontalLayout;
		
		
		private var _index:int;
		private var _owner:List;
		private var _factoryID:String;
		private var _data:ItemContent;
		
		private var _pickerList:AppPickerList;
		private var _textInput:AppTextInput;
		private var _removeButton:AppButton;
		
		public function ItemContentListItemRenderer()
		{
			super();
		}
		
		private static function thisLayout():HorizontalLayout
		{
			if (!_thisLayout) {
				_thisLayout = new HorizontalLayout();
				_thisLayout.paddingTop = _thisLayout.paddingBottom = 5;
				_thisLayout.paddingLeft = _thisLayout.paddingRight = 5;
				_thisLayout.gap = 5;
				_thisLayout.verticalAlign = VerticalAlign.MIDDLE;
				_thisLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
			}
			
			return _thisLayout;
		}
		
		private static function pickerItemRendererFactory():IListItemRenderer
		{
			var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = "name";
			return renderer;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			layout = thisLayout();
			
			_pickerList = new AppPickerList();
			_pickerList.labelField = "name";
			_pickerList.layoutData = _pickerLayoutData;
			addChild(_pickerList);
			
			_pickerList.dataProvider = itemsCollection;
			_pickerList.itemRendererFactory = pickerItemRendererFactory;
			
			_textInput = new AppTextInput();
			_textInput.restrict = "0-9";
			_textInput.layoutData = _inputLayoutData;
			addChild(_textInput);
			
			_removeButton = new AppButton("‒");
			_removeButton.bubblingEvents = false;
			_removeButton.layoutData = _removeLayoutData;
			_removeButton.addEventListener(Event.TRIGGERED, triggeredButtonHandler);
			addChild(_removeButton);
			
			new ItemContentListItemController(this);
		}
		
		override public function dispose():void
		{
			_removeButton.removeEventListener(Event.TRIGGERED, triggeredButtonHandler);
			removeDataListeners(_data);
			_data = null;
			_owner = null;
			super.dispose();
		}
		
		public function get data():Object {return _data;}
		public function set data(value:Object):void
		{
			if (value == _data) return;
			
			removeDataListeners(_data);
			
			_data = ItemContent(value);
			
			if (_data) {
				_data.addEventListener(ItemContentEvent.CHANGED_AMOUNT, changeHandler);
				_data.addEventListener(ItemContentEvent.CHANGED_ITEM_ID, changeHandler);
				updateLabel(String(_data.amount));
			} else {
				updateLabel("");
			}
		}
		
		public function get selectedItem():MoItem
		{
			return _pickerList.selectedItem as MoItem;
		}
		
		public function set selectedItem(value:MoItem):void
		{
			_pickerList.selectedItem = value;
		}
		
		public function get amount():int
		{
			return parseInt(_textInput.text);
		}
		
		private function triggeredButtonHandler(event:Event):void
		{
			dispatchEvent(new ContentListItemEvent(ContentListItemEvent.TRIGGERED_REMOVE_BUTTON, _data, true));
		}
		
		private function changeHandler(event:ItemContentEvent):void
		{
			updateLabel(String(_data.amount));
		}
		
		private function updateLabel(text:String):void
		{
			_textInput.text = text;
		}
		
		private function removeDataListeners(data:EventDispatcher):void
		{
			if (!data) return;
			data.removeEventListener(ItemContentEvent.CHANGED_AMOUNT, changeHandler);
			data.removeEventListener(ItemContentEvent.CHANGED_ITEM_ID, changeHandler);
		}
		
		public function get index():int {return _index;}
		public function set index(value:int):void {_index = value;}
		
		public function get owner():List {return _owner;}
		public function set owner(value:List):void {_owner = value;}
		
		public function get factoryID():String {return _factoryID;}
		public function set factoryID(value:String):void {_factoryID = value;}
		
		public function get isSelected():Boolean
		{
			return false;
		}
		
		public function set isSelected(value:Boolean):void
		{
		}
	}
}
