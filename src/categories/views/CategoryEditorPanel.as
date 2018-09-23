package categories.views
{
	import base.views.AppButton;
	import base.views.AppPickerList;
	import base.views.AppTextInput;
	
	import categories.controllers.CategoryEditorPanelController;
	import categories.models.MoCategory;
	
	import contents.collections.ContentsTypeEnum;
	
	import feathers.controls.Header;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.VectorCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	
	import items.models.MoItem;
	import items.views.*;
	
	import ru.aa.enums.Enum;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class CategoryEditorPanel extends Panel
	{
		public static const ADD_BUTTON:String = "addButton";
		public static const REMOVE_BUTTON:String = "removeButton";
		
		private static var _thisLayout:VerticalLayout;
		
		private var _addButton:AppButton;
		private var _removeButton:AppButton;
		private var _itemsList:ItemsList;
		private var _hasData:Boolean;
		private var _input:TextInput;
		private var _contentsTypePicker:AppPickerList;
		
		public function CategoryEditorPanel()
		{
			super();
			addEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		override public function dispose():void
		{
			removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
			_itemsList.dataProvider.removeEventListener(Event.CHANGE, changeListHandler);
			super.dispose();
		}
		
		private static function thisLayout():VerticalLayout
		{
			if (!_thisLayout) {
				_thisLayout = new VerticalLayout();
				_thisLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
				_thisLayout.verticalAlign = VerticalAlign.JUSTIFY;
				_thisLayout.gap = 5;
			}
			return _thisLayout;
		}
		
		private static function pickerItemRendererFactory():IListItemRenderer
		{
			var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = "locale";
			return renderer;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			layout = thisLayout();
			
			
			var titleLayout:HorizontalLayout = new HorizontalLayout();
			titleLayout.gap = 5;
			
			var title:LayoutGroup = new LayoutGroup();
			title.layout = titleLayout;
			addChild(title);
			
			_input = new AppTextInput();
			title.addChild(_input);
			
			_contentsTypePicker = new AppPickerList();
			addChild(_contentsTypePicker);
			
			_contentsTypePicker.labelField = "locale";
			_contentsTypePicker.itemRendererFactory = pickerItemRendererFactory;
			_contentsTypePicker.dataProvider = new VectorCollection(Enum.getElementsList(ContentsTypeEnum));
			
			_itemsList = new ItemsList();
			var listLayout:VerticalLayout = new VerticalLayout();
			listLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
			listLayout.verticalAlign = VerticalAlign.JUSTIFY;
			_itemsList.layout = listLayout;
			_itemsList.layoutData = new VerticalLayoutData(100, 100);
			addChild(_itemsList);
			
			_itemsList.dataProvider.addEventListener(Event.CHANGE, changeListHandler);
		}
		
		private function creationCompleteHandler(event:Event):void
		{
			removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
			
			_addButton = new AppButton("Add", ADD_BUTTON);
			_removeButton = new AppButton("Remove", REMOVE_BUTTON);
			
			var head:Header = Header(header);
			head.paddingBottom = 10;
			head.paddingTop = 10;
			head.leftItems = Vector.<DisplayObject>([_addButton, _removeButton]);
			
			validateHeader();
			
			new CategoryEditorPanelController(this);
		}
		
		private function changeListHandler(event:Event):void
		{
			validateHeader();
		}
		
		public function setData(category:MoCategory):void
		{
			_hasData = category != null;
			
//			_input.addEventListener(Event.CHANGE, inputChangeHandler);
//			_contentsTypePicker.addEventListener(Event.CHANGE, inputChangeHandler);
			addEventListener(Event.CHANGE, inputChangeHandler);
			if (category) {
				_input.text = category.name || "";
				_contentsTypePicker.selectedItem = category.contentsType;
			} else {
				_input.text = "";
				_contentsTypePicker.selectedItem = null;
			}
			removeEventListener(Event.CHANGE, inputChangeHandler);
//			_contentsTypePicker.removeEventListener(Event.CHANGE, inputChangeHandler);
//			_input.removeEventListener(Event.CHANGE, inputChangeHandler);
			
			validateHeader();
		}
		
		public function set contentsType(value:ContentsTypeEnum):void
		{
			if (value == _contentsTypePicker.selectedItem) return;
			addEventListener(Event.CHANGE, inputChangeHandler);
			_contentsTypePicker.selectedItem = value;
			removeEventListener(Event.CHANGE, inputChangeHandler);
		}
		
		private function inputChangeHandler(event:Event):void
		{
			event.stopImmediatePropagation();
			event.stopPropagation();
		}
		
		public function get selectedData():MoItem {return _itemsList.selectedData;}
		
		private function validateHeader():void
		{
			title = "Items: " + _itemsList.numItems;
			if (_addButton) _addButton.isEnabled = _hasData;
			if (_removeButton) _removeButton.isEnabled = _itemsList.numItems > 0;
			if (_input) _input.isEnabled = _hasData;
			if (_contentsTypePicker) _contentsTypePicker.isEnabled = _hasData;
		}
	}
}
