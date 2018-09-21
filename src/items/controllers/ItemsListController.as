package items.controllers
{
	import categories.events.CategoryEvent;
	import categories.models.MoCategory;
	
	import core.models.DataStore;
	
	import items.collections.ItemsManager;
	import items.events.ItemListEvent;
	import items.events.ItemsManagerEvent;
	import items.models.MoItem;
	import items.views.ItemsList;
	
	import ru.aa.march.controllers.ControllerFeathers;
	
	import starling.events.Event;
	
	public class ItemsListController extends ControllerFeathers
	{
		private var _itemsManager:ItemsManager;
		private var _category:MoCategory;
		
		public function ItemsListController(view:ItemsList)
		{
			super(view);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_itemsManager = DataStore.me.itemsManager;
			
			view.addEventListener(Event.CHANGE, selectItemHandler);
			_itemsManager.addEventListener(ItemsManagerEvent.ADDED_ITEM, itemsManagerHandler);
			_itemsManager.addEventListener(ItemsManagerEvent.REMOVED_ITEM, itemsManagerHandler);
			_itemsManager.addEventListener(ItemsManagerEvent.UPDATE_ALL, itemsManagerHandler);
			eventDispatcher.addEventListener(CategoryEvent.SELECTED, selectedCategoryHandler);
		}
		
		override public function destroy():void
		{
			view.removeEventListener(Event.CHANGE, selectItemHandler);
			_itemsManager.removeEventListener(ItemsManagerEvent.ADDED_ITEM, itemsManagerHandler);
			_itemsManager.removeEventListener(ItemsManagerEvent.REMOVED_ITEM, itemsManagerHandler);
			_itemsManager.removeEventListener(ItemsManagerEvent.UPDATE_ALL, itemsManagerHandler);
			eventDispatcher.removeEventListener(CategoryEvent.SELECTED, selectedCategoryHandler);
			super.destroy();
		}
		
		public function get view():ItemsList {return ItemsList(getView());}
		
		private function selectedCategoryHandler(event:CategoryEvent):void
		{
			if (_category && _category.equals(event.category)) return;
			
			_category = event.category;
			
			if (_category) {
				var items:Vector.<MoItem> = _itemsManager.getItemsFor(_category);
				view.setData(items, 0);
			} else {
				view.setData();
			}
		}
		
		private function selectItemHandler(event:Event):void
		{
			event.stopPropagation();
			
			var item:MoItem = view.selectedData as MoItem;
			eventDispatcher.dispatchEvent(new ItemListEvent(ItemListEvent.SELECTED_ITEM, item));
		}
		
		private function itemsManagerHandler(event:ItemsManagerEvent):void
		{
			
			switch (event.type) {
				case ItemsManagerEvent.ADDED_ITEM:
					view.addItem(event.item, true);
					break;
				case ItemsManagerEvent.REMOVED_ITEM:
					view.removeItem(event.item, true);
					break;
				case ItemsManagerEvent.UPDATE_ALL:
					var items:Vector.<MoItem> = _itemsManager.getItemsFor(_category);
					view.setData(items, 0);
					break;
			}
		}
	}
}
