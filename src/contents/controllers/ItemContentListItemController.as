package contents.controllers
{
	import base.views.AppPickerList;
	import base.views.AppTextInput;
	
	import contents.collections.ContentsTypeEnum;
	import contents.models.ItemContent;
	import contents.views.ItemContentListItemRenderer;
	
	import core.models.DataStore;
	
	import items.events.ItemsManagerEvent;
	import items.filters.ItemsByContentsTypeFilter;
	import items.models.MoItem;
	
	import ru.aa.march.controllers.ControllerFeathers;
	
	import starling.events.Event;
	
	public class ItemContentListItemController extends ControllerFeathers
	{
		private static const FILTER_BY_EFFECTS:ItemsByContentsTypeFilter = new ItemsByContentsTypeFilter(ContentsTypeEnum.EFFECTS);
		
		private static var _inited:Boolean;
		
		private static function initItemsList():void
		{
			if (_inited) return;
			DataStore.me.itemsManager.addEventListener(ItemsManagerEvent.ADDED_ITEM, updateItemsList);
			DataStore.me.itemsManager.addEventListener(ItemsManagerEvent.REMOVED_ITEM, updateItemsList);
			DataStore.me.itemsManager.addEventListener(ItemsManagerEvent.UPDATE_ALL, updateItemsList);
			updateItemsList();
			_inited = true;
		}
		
		private static function updateItemsList(event:ItemsManagerEvent = null):void
		{
			ItemContentListItemRenderer.itemsCollection.vectorData = DataStore.me.itemsManager.getItems(FILTER_BY_EFFECTS);
		}
		
		
		
		public function ItemContentListItemController(view:ItemContentListItemRenderer)
		{
			super(view);
		}
		
		public function get view():ItemContentListItemRenderer {return getView() as ItemContentListItemRenderer}
		
		override protected function initialize():void
		{
			super.initialize();
			
			initItemsList();
			
			var itemContent:ItemContent = view.data as ItemContent;
			var item:MoItem = DataStore.me.itemsManager.getItem(itemContent.itemID);
			
			view.selectedItem = item;
			
			view.addEventListener(Event.CHANGE, changeHandler);
		}
		
		override public function destroy():void
		{
			view.removeEventListener(Event.CHANGE, changeHandler);
			super.destroy();
		}
		
		private function changeHandler(event:Event):void
		{
			var itemContent:ItemContent = view.data as ItemContent;
			if (!itemContent) return;
			
			switch (true) {
				case event.target is AppTextInput:
					itemContent.amount = view.amount;
					break;
				case event.target is AppPickerList:
					if (view.selectedItem) itemContent.itemID = view.selectedItem.id;
					break;
			}
		}
	}
}
