package categories.controllers
{
	import base.controllers.ControllerFeathers;
	
	import categories.events.CategoryEvent;
	
	import categories.models.MoCategory;
	
	import categories.models.MoCategory;
	
	import categories.views.CategoryListItemRenderer;
	
	import core.models.DataStore;
	
	import feathers.core.FeathersControl;
	
	import items.collections.ItemsManager;
	
	import items.events.ItemsManagerEvent;
	
	public class CategoryListItemRendererController extends ControllerFeathers
	{
		private var _category:MoCategory;
		private var _itemsManager:ItemsManager;
		
		public function CategoryListItemRendererController(view:CategoryListItemRenderer)
		{
			super(view);
		}
		
		public function get view():CategoryListItemRenderer {return getView() as CategoryListItemRenderer;}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_itemsManager = DataStore.me.itemsManager;
			
			_category = view.data as MoCategory;
			
			updateListItemRenderer();
			
			_itemsManager.addEventListener(ItemsManagerEvent.ADDED_ITEM, itemsManagerHandler);
			_itemsManager.addEventListener(ItemsManagerEvent.REMOVED_ITEM, itemsManagerHandler);
			_itemsManager.addEventListener(ItemsManagerEvent.UPDATE_ALL, itemsManagerHandler);
			_category.addEventListener(CategoryEvent.CHANGED_NAME, categoryHandler);
			_category.addEventListener(CategoryEvent.CHANGED_CONTENTS_TYPE, categoryHandler);
		}
		
		override public function destroy():void
		{
			_itemsManager.removeEventListener(ItemsManagerEvent.ADDED_ITEM, itemsManagerHandler);
			_itemsManager.removeEventListener(ItemsManagerEvent.REMOVED_ITEM, itemsManagerHandler);
			_itemsManager.removeEventListener(ItemsManagerEvent.UPDATE_ALL, itemsManagerHandler);
			_category.removeEventListener(CategoryEvent.CHANGED_NAME, categoryHandler);
			_category.removeEventListener(CategoryEvent.CHANGED_CONTENTS_TYPE, categoryHandler);
			super.destroy();
		}
		
		private function categoryHandler(event:CategoryEvent):void
		{
			updateListItemRenderer();
		}
		
		private function itemsManagerHandler(event:ItemsManagerEvent):void
		{
			updateListItemRenderer();
		}
		
		private function updateListItemRenderer():void
		{
			if (_category) {
				var numItems:int = _itemsManager.getNumItemsFor(_category);
				view.setInfo(_category.contentsType.getString(), _category.name, numItems);
			} else {
				view.label = "null";
			}
		}
	}
}
