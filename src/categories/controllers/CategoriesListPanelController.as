package categories.controllers
{
	import base.controllers.ControllerFeathers;
	
	import categories.collections.CategoriesManager;
	import categories.commands.AddCategory;
	import categories.commands.RemoveCategory;
	import categories.events.CategoriesManagerEvent;
	import categories.events.CategoryEvent;
	import categories.models.MoCategory;
	import categories.views.CategoriesListPanel;
	
	import core.models.DataStore;
	
	import feathers.controls.Button;
	
	import items.collections.ItemsManager;
	
	import starling.events.Event;
	
	public class CategoriesListPanelController extends ControllerFeathers
	{
		private var _categoriesManager:CategoriesManager;
		private var _itemsManager:ItemsManager;
		
		public function CategoriesListPanelController(view:CategoriesListPanel)
		{
			super(view);
		}
		
		public function get view():CategoriesListPanel {return getView() as CategoriesListPanel;}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_categoriesManager = DataStore.me.categoriesManager;
			_itemsManager = DataStore.me.itemsManager;
			
			view.setData(_categoriesManager.categories);
			
			view.addEventListener(Event.TRIGGERED, triggeredButtonHandler);
			view.addEventListener(Event.CHANGE, selectCategoryHandler);
			_categoriesManager.addEventListener(CategoriesManagerEvent.ADDED_CATEGORY, categoriesManagerHandler);
			_categoriesManager.addEventListener(CategoriesManagerEvent.REMOVED_CATEGORY, categoriesManagerHandler);
			_categoriesManager.addEventListener(CategoriesManagerEvent.UPDATED_ALL, categoriesManagerHandler);
		}
		
		override public function destroy():void
		{
			view.removeEventListener(Event.TRIGGERED, triggeredButtonHandler);
			view.removeEventListener(Event.CHANGE, selectCategoryHandler);
			_categoriesManager.removeEventListener(CategoriesManagerEvent.ADDED_CATEGORY, categoriesManagerHandler);
			_categoriesManager.removeEventListener(CategoriesManagerEvent.REMOVED_CATEGORY, categoriesManagerHandler);
			_categoriesManager.removeEventListener(CategoriesManagerEvent.UPDATED_ALL, categoriesManagerHandler);
			super.destroy();
		}
		
		private function categoriesManagerHandler(event:CategoriesManagerEvent):void
		{
			switch (event.type) {
				case CategoriesManagerEvent.ADDED_CATEGORY:
					view.addData(event.category, true);
					break;
				case CategoriesManagerEvent.REMOVED_CATEGORY:
					view.removeData(event.category, true);
					break;
				case CategoriesManagerEvent.UPDATED_ALL:
					view.setData(_categoriesManager.categories, 0);
					break;
			}
		}
		
		private function selectCategoryHandler(event:Event):void
		{
			eventDispatcher.dispatchEvent(new CategoryEvent(CategoryEvent.SELECTED, MoCategory(view.selectedData)));
		}
		
		private function triggeredButtonHandler(event:Event):void
		{
			var button:Button = event.target as Button;
			if (!button) return;
			
			switch (button.name) {
				case CategoriesListPanel.ADD_BUTTON:
					new AddCategory().execute("Category");
					break;
				case CategoriesListPanel.REMOVE_BUTTON:
					var category:MoCategory = MoCategory(view.selectedData);
					new RemoveCategory().execute(category);
					break;
			}
		}
	}
}
