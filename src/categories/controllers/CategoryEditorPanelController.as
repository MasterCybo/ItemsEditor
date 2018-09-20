package categories.controllers
{
	import base.controllers.ControllerFeathers;
	import base.views.AppPickerList;
	import base.views.AppTextInput;
	
	import categories.events.CategoryEvent;
	import categories.models.MoCategory;
	import categories.views.CategoryEditorPanel;
	
	import contents.collections.ContentsTypeEnum;
	
	import core.events.PopupEvent;
	import core.models.DataStore;
	
	import feathers.controls.Button;
	
	import items.commands.AddItem;
	import items.commands.RemoveItem;
	import items.models.MoItem;
	
	import starling.events.Event;
	
	public class CategoryEditorPanelController extends ControllerFeathers
	{
		private static var _counter:int;
		
		private var _category:MoCategory;
		private var _newContentsType:ContentsTypeEnum;
		private var _removedItems:Vector.<MoItem>;
		
		public function CategoryEditorPanelController(view:CategoryEditorPanel)
		{
			super(view);
		}
		
		public function get view():CategoryEditorPanel {return getView() as CategoryEditorPanel;}
		
		override protected function initialize():void
		{
			super.initialize();
			
			view.addEventListener(Event.TRIGGERED, triggeredButtonHandler);
			view.addEventListener(Event.CHANGE, changeHandler);
			eventDispatcher.addEventListener(CategoryEvent.SELECTED, selectedCategoryHandler);
		}
		
		override public function destroy():void
		{
			view.removeEventListener(Event.TRIGGERED, triggeredButtonHandler);
			view.removeEventListener(Event.CHANGE, changeHandler);
			eventDispatcher.removeEventListener(CategoryEvent.SELECTED, selectedCategoryHandler);
			
			super.destroy();
		}
		
		private function selectedCategoryHandler(event:CategoryEvent):void
		{
			if (event.category == _category) return;
			
			_category = event.category;
			
			view.setData(_category);
		}
		
		private function changeHandler(event:Event):void
		{
			if (!_category) return;
			
			switch (true) {
				case event.target is AppTextInput:
					_category.name = AppTextInput(event.target).text;
					break;
				case event.target is AppPickerList:
					_newContentsType = AppPickerList(event.target).selectedItem as ContentsTypeEnum;
					_removedItems = DataStore.me.itemsManager.getItemsFor(_category);
					if (!_category.contentsType.equals(_newContentsType)) {
						if (_removedItems && _removedItems.length > 0) {
							eventDispatcher.dispatchEvent(
									new PopupEvent(
											PopupEvent.SHOW_PERMISSION,
											"Change Contents Type?",
											"All objects in this category will be deleted.",
											setupContentsType,
											revertContentsType
									)
							);
						} else {
							setupContentsType();
						}
					} else {
						revertContentsType();
					}
					break;
			}
		}
		
		private function setupContentsType():void
		{
			DataStore.me.itemsManager.removeItems(_removedItems);
			_category.contentsType = _newContentsType;
		}
		
		private function revertContentsType():void
		{
			view.contentsType = _category.contentsType;
		}
		
		private function triggeredButtonHandler(event:Event):void
		{
			var button:Button = event.target as Button;
			if (!button) return;
			
			switch (button.name) {
				case CategoryEditorPanel.ADD_BUTTON:
					new AddItem(_category, "Item" + (_counter++)).execute();
					break;
				case CategoryEditorPanel.REMOVE_BUTTON:
					new RemoveItem(view.selectedData).execute();
					break;
			}
		}
	}
}
