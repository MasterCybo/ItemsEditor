package items.views
{
	import base.views.AppList;
	
	import feathers.controls.LayoutGroup;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ArrayCollection;
	import feathers.data.VectorCollection;
	
	import items.controllers.ItemsListController;
	import items.models.MoItem;
	
	public class ItemsList extends LayoutGroup
	{
		private var _list:AppList;
		
		public function ItemsList()
		{
			super();
		}
		
		private static function itemRenderFactory():IListItemRenderer
		{
			var itemRenderer:ItemListItemRenderer = new ItemListItemRenderer();
			return itemRenderer;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_list = new AppList();
			_list.layout = layout;
			_list.layoutData = layoutData;
			_list.dataProvider = new VectorCollection();
			_list.itemRendererFactory = itemRenderFactory;
			addChild(_list);
			
			new ItemsListController(this);
		}
		
		public function get dataProvider():VectorCollection {return _list.dataProvider as VectorCollection;}
		
		public function get selectedData():MoItem {return _list.selectedItem as MoItem;}
		
		public function get numItems():int {return _list.dataProvider.length;}
		
		public function setData(items:Vector.<MoItem> = null, selectIndex:int = -1):void
		{
			_list.dataProvider.removeAll();
			
			if (items) {
				for (var i:int = 0; i < items.length; i++) {
					addItem(items[ i ]);
				}
			}
			
			if (selectIndex > -1) {
				selectIndex = Math.min(selectIndex, _list.dataProvider.length - 1);
				_list.selectedIndex = selectIndex;
			}
		}
		
		public function addItem(item:MoItem, select:Boolean = false):void
		{
			_list.dataProvider.push(item);
			if (select) {
				_list.selectedIndex = _list.dataProvider.length - 1;
			}
		}
		
		public function removeItem(item:MoItem, selectNext:Boolean = false):void
		{
			var nextIndex:int = _list.dataProvider.getItemIndex(item);
			_list.dataProvider.removeItem(item);
			
			if (selectNext) {
				nextIndex = _list.dataProvider.length > 0 ? Math.min(nextIndex, _list.dataProvider.length - 1) : -1;
				_list.selectedIndex = nextIndex;
			}
			
		}
	}
}
