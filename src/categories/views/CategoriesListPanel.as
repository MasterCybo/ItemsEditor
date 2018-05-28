package categories.views
{
	import base.views.AppButton;
	import base.views.AppList;
	
	import categories.controllers.CategoriesListPanelController;
	import categories.models.MoCategory;
	
	import feathers.controls.Header;
	import feathers.controls.Panel;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ArrayCollection;
	import feathers.data.VectorCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class CategoriesListPanel extends Panel
	{
		public static const ADD_BUTTON:String = "addButton";
		public static const REMOVE_BUTTON:String = "removeButton";
		
		private static var _thisLayout:VerticalLayout;
		
		private var _removeButton:AppButton;
		private var _list:AppList;
		private var _dataProvider:VectorCollection;
		
		public function CategoriesListPanel()
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
			}
			return _thisLayout;
		}
		
		private static function itemRenderFactory():IListItemRenderer
		{
			var itemRenderer:CategoryListItemRenderer = new CategoryListItemRenderer();
			return itemRenderer;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			layout = thisLayout();
			
			_list = new AppList();
			_list.layoutData = new VerticalLayoutData(100, 100);
			_list.dataProvider = _dataProvider = new VectorCollection();
			
			_list.itemRendererFactory = itemRenderFactory;
			
			addChild(_list);
		}
		
		private function creationCompleteHandler(event:Event):void
		{
			removeEventListener(FeathersEventType.CREATION_COMPLETE, creationCompleteHandler);
			
			var addButton:AppButton = new AppButton("Add", ADD_BUTTON);
			_removeButton = new AppButton("Remove", REMOVE_BUTTON);
			
			var head:Header = Header(header);
			head.paddingBottom = 10;
			head.paddingTop = 10;
			head.leftItems = Vector.<DisplayObject>([addButton, _removeButton]);
			
			new CategoriesListPanelController(this);
		}
		
		public function get selectedData():Object {return _list.selectedItem;}
		
		public function setData(data:Vector.<MoCategory>, selectIndex:int = -1):void
		{
			_dataProvider.removeAll();
			
			var element:MoCategory;
			
			for (var i:int = 0; i < data.length; i++) {
				element = data[ i ];
				pushElement(element);
			}
			
			validateHeader(_dataProvider.length);
			
			if (selectIndex > -1) {
				selectIndex = Math.min(selectIndex, _dataProvider.length - 1);
				_list.selectedIndex = selectIndex;
			}
		}
		
		public function addData(element:MoCategory, select:Boolean = false):void
		{
			pushElement(element);
			validateHeader(_dataProvider.length);
			
			if (select) {
				_list.selectedIndex = _dataProvider.length - 1;
			}
			
			_list.itemToItemRenderer(element)
		}
		
		public function removeData(element:MoCategory, selectNext:Boolean = false):void
		{
			var nextIndex:int = -1;
			
			if (!element) {
				_dataProvider.pop();
				nextIndex = _dataProvider.length - 1;
			} else {
				var idx:int = _dataProvider.getItemIndex(element);
				_dataProvider.removeItem(element);
				if (idx != -1) {
					nextIndex = _dataProvider.length > 0 ? Math.min(idx, _dataProvider.length - 1) : -1;
				}
			}
			
			validateHeader(_dataProvider.length);
			
			if (selectNext != -1) {
				_list.selectedIndex = nextIndex;
			}
		}
		
		private function pushElement(element:MoCategory):void
		{
			_dataProvider.push(element);
		}
		
		private function validateHeader(count:int):void
		{
			title = "Categories: " + count;
			_removeButton.isEnabled = count > 0;
		}
	}
}
